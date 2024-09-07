import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';

AppBar Back_appBar(BuildContext context, String title){
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
    title: Center(
      child: Text(
          title,
        style: isDark? TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roman',
          color: Title_color,
        ):TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roman',
          color: Colors.white,
        ),
      )
      ,),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications,
          size: 30,
          color: isDark?Title_color:Colors.white,
        ),
        tooltip: 'Open notification',
        onPressed: (){

        },
      ),
    ],
  );
}