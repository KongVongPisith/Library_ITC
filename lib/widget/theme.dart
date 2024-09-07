import 'package:flutter/material.dart';
import 'package:itc_library/constant/colorSet.dart';

class Custom_theme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.cyan,
    backgroundColor: Colors.white,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roman',
        fontSize: 40,
        color: Title_color,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Merri',
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Merri',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: 'Bitter_regular',
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
        fontFamily: 'Bitter_regular',
      ),
      bodySmall: TextStyle(
        fontFamily: 'Bitter_regular',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Roman',
          fontSize: 25,
          color: Title_color,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontFamily: 'Bitter_regular',
          fontWeight: FontWeight.bold,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,

        ),
        titleSmall: TextStyle(
          fontFamily: 'Bitter_regular',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: 'Bitter_regular',
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          fontFamily: 'Bitter_regular',
        ),
        bodySmall: TextStyle(
          fontFamily: 'Bitter_regular',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
          overflow: TextOverflow.ellipsis
        ),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    primaryColor: Colors.black26,
    primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roman',
        fontSize: 40,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Merri',
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Merri',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: 'Bitter_regular',
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Bitter_regular',
      ),
      bodySmall: TextStyle(
        fontFamily: 'Bitter_regular',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Roman',
        fontSize: 25,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Bitter_regular',
        fontWeight: FontWeight.bold,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Bitter_regular',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
          fontSize: 15,
          fontFamily: 'Bitter_regular',
          fontWeight: FontWeight.w500,
          color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
        fontFamily: 'Bitter_regular',
      ),
      bodySmall: TextStyle(
        fontFamily: 'Bitter_regular',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
  static final lightBackgroundImage = 'assets/rm222batch2-mind-03.jpg';
  static final darkBackgroundImage = 'assets/darktheme.png';
  static final drawerLightBackground = 'assets/3361238.jpg';
  static final drawerDarkBackground = 'assets/drawerDark.png';
}
