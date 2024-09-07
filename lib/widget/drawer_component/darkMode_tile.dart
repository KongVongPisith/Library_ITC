import 'package:flutter/material.dart';
import 'package:itc_library/widget/Toggle_switch.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:itc_library/widget/theme_provider.dart';
import 'package:provider/provider.dart';

ListTile DarkMode_tile(BuildContext context){
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  return ListTile(
    title: Row(
      children: <Widget>[
        Text(
            'Theme Mode',
          style: Theme.of(context).primaryTextTheme.titleMedium,
        ),
        Spacer(),
        IconButton(
            onPressed: (){
              themeProvider.setTheme(themeProvider.getTheme() == Custom_theme.darkTheme? Custom_theme.lightTheme:Custom_theme.darkTheme);
            },
            icon: Icon(
                themeProvider.getTheme() == Custom_theme.darkTheme?Icons.light_mode_outlined:Icons.dark_mode_outlined)
        ),
      ],
    ),
  );
}