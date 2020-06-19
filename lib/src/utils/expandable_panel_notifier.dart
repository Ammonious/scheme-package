import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_package/src/global_widgets/expandable_panel.dart';

class ExpandablePanelStream extends ChangeNotifier {


	final _focusStreamSubject = PublishSubject<bool>(); 


	Stream<bool> expandableStream(ExpandableController controller) {
		controller.addListener(() => _focusStreamSubject.add(controller.expanded));
		return _focusStreamSubject;
	}


	Stream<bool> groupStream(List<ExpandableController> controllers) {
		controllers.forEach((element) {

		});
		return _focusStreamSubject;
	}

}