import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';
import 'package:itc_library/widget/theme.dart';
import 'package:itc_library/widget/theme_provider.dart';

AppBar JustBack(BuildContext context){
  final theme = Theme.of(context);
  bool isDark = true;
  if(theme.brightness==Brightness.light){
    isDark = true;
  }else{
    isDark=false;
  }
  return AppBar(
    leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              size: 30,
              Icons.arrow_back_ios_new_outlined,
              color: isDark? Title_color:Colors.white,
            ),
          );
        }
    ),

    backgroundColor: Colors.transparent,
    toolbarHeight: 50,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  );
}