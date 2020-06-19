import 'package:flutter/material.dart';
import 'package:scheme_package/src/ui/transition_builders.dart';

Future<T> showSchemeDialog<T>({
	                        @required BuildContext context,
	                        bool barrierDismissible = true,
													TransitionTypes transitionType,
													Widget child,
	                        WidgetBuilder builder,
	                        bool useRootNavigator = true,
                        }) {


	final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
	return showGeneralDialog(
		context: context,
		pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
			final Widget pageChild = child ?? Builder(builder: builder);
			return SafeArea(
				child: Builder(
						builder: (BuildContext context) {
							return theme != null
									? Theme(data: theme, child: pageChild)
									: pageChild;
						}
				),
			);
		},
		barrierDismissible: barrierDismissible,
		barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
		barrierColor: Colors.black54,
		transitionDuration: Duration(milliseconds: transitionType == TransitionTypes.ZoomIn ? 150 : 450),
		transitionBuilder: initTransitionType(transitionType),
		useRootNavigator: useRootNavigator,
	);
}