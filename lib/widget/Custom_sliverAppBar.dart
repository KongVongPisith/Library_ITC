import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';

SliverAppBar Custom_SliverAppBar(BuildContext context){

  final theme = Theme.of(context);
  bool isDark = true;
  if(theme.brightness==Brightness.light){
    isDark = true;
  }else{
    isDark=false;
  }

  return SliverAppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.menu_open_outlined,
            size: 40,
            color: isDark ? Title_color : Colors.white,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          alignment: Alignment.center,
        );
      },
    ),
    backgroundColor: Colors.transparent,
    toolbarHeight: 50,
    floating: true,
    snap: true,
    elevation: 0,
    scrolledUnderElevation: 100,
    title: Text(
      'Library',
      style: Theme.of(context).primaryTextTheme.titleLarge,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.notifications,
          size: 30,
          color: isDark ? Title_color : Colors.white,
        ),
        tooltip: 'Open notification',
        onPressed: () {},
      ),
    ],
  );
}
