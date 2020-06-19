import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/icons/flare_icon.dart';

class SelectionNotifier extends ChangeNotifier {
  int lastIndex;
  int currentIndex;
  final ValueChanged<int> onTap;
  final _streamSubject = PublishSubject<int>();
  SelectionNotifier(int defaultValue, this.onTap,) : currentIndex = defaultValue;

  Stream<int> get indexStream =>  _streamSubject;


  void selectIndex(int index) {
    lastIndex = currentIndex;
    currentIndex = index;
    _streamSubject.add(index);
    onTap(index);
    notifyListeners();
  }
}