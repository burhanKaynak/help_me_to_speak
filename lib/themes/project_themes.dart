import 'package:flutter/material.dart';

const colorDarkGreen = Color(0xff046d54);
const colorLightGreen = Color(0xff00b267);
const colorHint = Color(0xffc1c1c1);
const colorBackground = Color(0xffc1c1c1);
const colorPrimary = Colors.redAccent;
const colorAppHeader = Color(0xffc1c1c1);
const colorAppNavigationBar = Color(0xffc1c1c1);
ThemeData lightTheme = ThemeData().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffefefef),
    iconTheme: const IconThemeData(
      color: colorLightGreen,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        focusColor: Colors.black,
        iconColor: colorHint,
        labelStyle: TextStyle(color: Colors.black)),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return colorLightGreen;
            } else {
              return colorHint;
            }
          },
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        unselectedItemColor: Color(0xff32343a),
        selectedItemColor: colorLightGreen,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        elevation: 0,
        backgroundColor: Color(0xffefefef)),
    hintColor: colorHint,
    textTheme: const TextTheme(
      headline5: TextStyle(fontWeight: FontWeight.w500),
    ));
ThemeData darkTheme = ThemeData().copyWith(brightness: Brightness.dark);
