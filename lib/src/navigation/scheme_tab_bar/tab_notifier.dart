import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TabNotifier extends ChangeNotifier {


  final _indexSubject = PublishSubject<int>();
  final _offsetSubject = PublishSubject<double>();
  final _animationOffset = PublishSubject<double>();


  Stream<int> indexStream(TabController tabController) {
    tabController.addListener(() => _indexSubject.add(tabController.index));
    return _indexSubject;
  }


  Stream<double> offsetStream(TabController tabController) {
    tabController.addListener(() => _offsetSubject.add(tabController.animation.value));
    return _offsetSubject;
  }

  Stream<double> animationStream(TabController tabController) {
    _animationOffset.add(tabController.animation.value);
    return _animationOffset;
  }

}