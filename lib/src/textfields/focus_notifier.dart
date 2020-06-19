import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/scheme_package.dart';

class FocusNotifier extends ChangeNotifier {


	final _focusStreamSubject = PublishSubject<bool>();
	final _nextFocusStreamSubject = PublishSubject<bool>();


	Stream<bool> mainStream(FocusNode focusNode) {
		  focusNode.addListener(() => _focusStreamSubject.add(focusNode.hasFocus));
		return _focusStreamSubject;
	}

	Stream<bool> nextStream(FocusNode focusNode) {

		if(focusNode != null){
			focusNode.addListener(() => _nextFocusStreamSubject.add(focusNode.hasFocus));
		}
		return _nextFocusStreamSubject;
	}

}