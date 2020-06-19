import 'dart:async';

import 'package:flutter/material.dart';

import '../../scheme_package.dart';



/// A widget that rebuilds on specific and / or periodic Timer events.
class TimeDismissBuilder extends StatefulWidget {
  final WidgetBuilder builder;
  final TimerGenerator generator;
  final Widget child;
  final bool enabled;
  final Function onFire;
  /// Use this constructor only if you need to provide a custom TimerGenerator.
  /// For general cases, prefer to use [TimeDismissBuilder.periodic] and [TimerBuilder..scheduled]
  /// This constructor accepts a custom generator function that returns the next time event
  /// to rebuild on.
  TimeDismissBuilder({
    /// Returns the next time event. If the returned time is in the past, it will be ignored and
    /// the generator will be called again to retrieve the next time event.
    /// If the generator returns [null], it indicates the end of time event sequence.
    @required
    this.generator,
    /// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
    @required
    this.builder, this.onFire, this.child,  this.enabled = true,
  });

  @override
  State<StatefulWidget> createState() {
    return _TimeDismissBuilderState();
  }

  /// Rebuilds periodically
  TimeDismissBuilder.periodic(Duration interval, {
    /// Specifies the alignment unit for the generated time events. Specify Duration.zero
    /// if you want no alignment. By default, the alignment unit is computed from the interval.
    Duration alignment,
    /// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
    this.builder, this.onFire, this.child, this.enabled = true,
  }): this.generator = periodicTimer(interval, alignment: alignment ?? getAlignmentUnit(interval));

  /// Rebuilds on a schedule
  TimeDismissBuilder.scheduled(Iterable<DateTime> schedule, {
    /// Builds the widget. Called for every time event or when the widget needs to be built/rebuilt.
    @required
    this.builder, this.onFire, this.child, this.enabled = true,
  }): this.generator = scheduledTimer(schedule);

}

class _TimeDismissBuilderState extends State<TimeDismissBuilder> {

  Stream<DateTime> stream;
  Completer completer;

  @override
  Widget build(BuildContext context) {
    return  widget.enabled ?
     StreamBuilder(
      stream: stream,
      builder: (context, _) {
        if(widget.onFire != null) widget.onFire();
        return widget.child;
      },
    ) : widget.child;
  }

  @override
  void didUpdateWidget(TimeDismissBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.enabled) _update();
  }

  @override
  void initState() {
    super.initState();
    if(widget.enabled) _update();
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.enabled) _cancel();
  }

  _update() {
    _cancel();
    completer = Completer();
    stream = createTimerStream(widget.generator, completer.future);
  }

  _cancel() {
    if(completer != null)
      completer.complete();
  }

}



