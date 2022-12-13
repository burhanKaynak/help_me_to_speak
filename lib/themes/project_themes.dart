import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
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
  textTheme: _textTheme,
);
ThemeData darkTheme = ThemeData().copyWith(brightness: Brightness.dark);

TextTheme get _textTheme => TextTheme(
    subtitle1: TextStyle(fontSize: 15.sp),
    subtitle2: TextStyle(fontSize: 12.5.sp),
    bodyText1: TextStyle(fontSize: 12.5.sp),
    bodyText2: TextStyle(fontSize: 10.sp),
    headline1: TextStyle(fontSize: 40.sp),
    headline2: TextStyle(fontSize: 35.sp),
    headline3: TextStyle(fontSize: 30.sp),
    headline4: TextStyle(fontSize: 25.sp),
    headline5: TextStyle(fontSize: 15.sp),
    headline6: TextStyle(fontSize: 10.sp));
