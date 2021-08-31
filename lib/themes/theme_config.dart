import 'package:covid19app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  accentColor: Colors.purple,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    actionsIconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black87,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kPrimaryColor,
    unselectedLabelColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xFF1E1E2C),
  accentColor: Colors.tealAccent,
  scaffoldBackgroundColor: Color(0xFF2D2D44),
  backgroundColor: Color(0xFF2D2D44),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.tealAccent,
  )),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.tealAccent,
    ),
    iconTheme: IconThemeData(
      color: Colors.tealAccent,
      size: 21,
    ),
  ),
  cardColor: Color(0xFF1E1E2C),
);

ThemeData darkBlueTheme = darkTheme.copyWith(
  primaryColor: Color(0xFF1E1E2C),
  accentColor: Colors.tealAccent,
  scaffoldBackgroundColor: Color(0xFF2D2D44),
  backgroundColor: Color(0xFF2D2D44),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.tealAccent,
  )),
  iconTheme: IconThemeData(
    color: Colors.tealAccent,
    size: 21,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.tealAccent,
    ),
    iconTheme: IconThemeData(
      color: Colors.tealAccent,
      size: 21,
    ),
  ),
);
