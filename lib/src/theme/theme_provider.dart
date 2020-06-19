
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheme_package/src/global_widgets/loading_view.dart';
import 'package:scheme_package/src/theme/theme_manager.dart';
import 'package:scheme_package/src/theme/theme_model.dart';
import 'package:scheme_package/src/theme/theme_builder.dart';

import 'theme_provider_model.dart';

class SchemeThemeProvider extends StatelessWidget {
  final ThemeModel themeModel;
  final SchemeTheme theme;
  final Widget Function(BuildContext context, ThemeData themeData, Widget child) builder;
  SchemeThemeProvider({Key key, this.builder, this.themeModel, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [themeModel.streamProvider],
        child: Material(
          color: themeModel.canvasColor, child: Consumer<ThemeProviderModel>(builder: (context, model, child) {
          if (themeModel.streamProvider != null && model == null) return LoadingView(color: themeModel.themeColor);
          return DynamicColorTheme(
            defaultIsDark: true,
            defaultColor: themeModel.themeColor,
            themedWidgetBuilder: (c, t) => builder(c, t, child),
            data: (Color color, bool isDark) => theme.buildTheme(themeModel,model, isDark),

          );
        }),));
  }
  
  
}


