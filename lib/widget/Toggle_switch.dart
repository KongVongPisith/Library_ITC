import 'package:flutter/material.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:itc_library/widget/theme_provider.dart';
import 'package:provider/provider.dart';
class ThemeToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Switch(
      value: themeProvider.getTheme() == Custom_theme.darkTheme,
      onChanged: (value) {
        themeProvider.setTheme(value ? Custom_theme.darkTheme : Custom_theme.lightTheme);
      },
    );
  }
}