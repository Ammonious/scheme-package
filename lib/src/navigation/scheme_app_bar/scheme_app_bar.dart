import 'package:flutter/material.dart';
import 'package:scheme_package/scheme_package.dart';
import 'package:scheme_package/src/navigation/utils/nav_bar_controller.dart';

import 'fading_app_bar.dart';

class SchemeAppBar extends StatefulWidget with PreferredSizeWidget {
  final NavBarScrollController appBarController;
  final SchemeAppBarProperties properties;

  SchemeAppBar({
    Key key,
    @required this.appBarController,
    this.properties,
  })  : assert(appBarController != null),
        super(key: key);

  @override
  _SchemeAppBarState createState() => _SchemeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SchemeAppBarState extends State<SchemeAppBar> {
  Widget appBar;
  double elevation;
  Color backgroundColor;

  SchemeAppBarProperties get properties => widget.properties;

  @override
  void initState() {
    super.initState();

    switch (properties.schemeBarStyle) {
      case SchemeBarStyle.classic:
      case SchemeBarStyle.flat:
        appBar = AppBar(
          automaticallyImplyLeading: properties.automaticallyImplyLeading,
          title: properties.title,
          actions: properties.actions,
          flexibleSpace: properties.flexibleSpace,
          bottom: properties.bottom,
          elevation: 0.0,
          leading: properties.leading,
          backgroundColor: Colors.transparent,
          brightness: properties.brightness,
          iconTheme: properties.iconTheme,
          actionsIconTheme: properties.actionsIconTheme,
          textTheme: properties.textTheme,
          primary: properties.primary,
          centerTitle: properties.centerTitle,
          titleSpacing: properties.titleSpacing,
          bottomOpacity: properties.bottomOpacity,
          toolbarOpacity: properties.toolbarOpacity,
          shape: properties.shape,
        );
        break;
      case SchemeBarStyle.neu:
        break;

      case SchemeBarStyle.fading:
        appBar = FadingAppBar(
          scrollController: widget.appBarController.scrollController,
          title: properties.title,
          height: widget.appBarController.height,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = properties.backgroundColor ??
        Theme.of(context).appBarTheme.color ??
        Theme.of(context).primaryColor;

    elevation =
        properties.elevation ?? Theme.of(context).appBarTheme.elevation ?? 4.0;

    return StreamBuilder<bool>(
      stream: widget.appBarController.pinStream,
      builder: _pinBuilder,
    );
  }

  Widget _pinBuilder(
    BuildContext context,
    AsyncSnapshot<bool> pinSnapshot,
  ) {
    if (!pinSnapshot.hasData || pinSnapshot.data) {
      return _elevation(1.0);
    }
    return StreamBuilder(
      stream: widget.appBarController.heightFactorStream,
      builder: _heightFactorBuilder,
    );
  }

  Widget _heightFactorBuilder(
    BuildContext context,
    AsyncSnapshot<double> heightFactorSnapshot,
  ) {
    if (!heightFactorSnapshot.hasData) {
      return _elevation(1.0);
    }
    return _align(heightFactorSnapshot.data);
  }

  Widget _align(double heightFactor) {
    return Align(
      alignment: Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: elevation,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.appBarController.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: properties.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: appBar,
    );
  }
}
