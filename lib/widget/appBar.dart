import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itc_library/constant/colorSet.dart';

AppBar Custom_appbar (BuildContext context){
  final theme = Theme.of(context);
  bool isDark = true;
  if(theme.brightness==Brightness.light){
    isDark = true;
  }else{
    isDark=false;
  }
  return AppBar(
    leading: Builder(
      builder: (BuildContext context){
        return Container(
          child: IconButton(
            icon: Icon(
              Icons.library_books_outlined,
              size: 35,
              color: isDark?Title_color:Colors.white,
            ),
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
            alignment: Alignment.center,
          ),
        );
      },
    ),
    backgroundColor: Colors.transparent,
    toolbarHeight: 50,
    surfaceTintColor: Colors.transparent,
    title: Text(
      'Library',
      style: Theme.of(context).primaryTextTheme.titleLarge,
      textAlign: TextAlign.center,
    ),
    actions: <Widget> [
      IconButton(
        icon: Icon(
          Icons.notifications,
          size: 30,
          color:  isDark?Title_color:Colors.white,
        ),
        tooltip: 'Open notification',
        onPressed: (){

        },
      ),
    ],
  );
}