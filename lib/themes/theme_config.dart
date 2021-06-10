import 'package:covid19app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  accentColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    actionsIconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kPrimaryColor,
    unselectedLabelColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData.dark();

ThemeData darkBlueTheme = darkTheme.copyWith(
  primaryColor: Color(0xFF1E1E2C),
  scaffoldBackgroundColor: Color(0xFF2D2D44),
);
