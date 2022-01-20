import 'package:flutter/material.dart';

class AppThemes {
  static final themes = {
    darkOrLight.darkTheme: ThemeData(
        accentColor: Color(0xFF122543),
        primaryColor: Color(0xFF122543),
        primaryColorDark: Color(0xFF122543),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Color(0xFF8CD7AE),
        textTheme: TextTheme(
          //HEADING LARGE
          headline1: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w700),
          //HEADING MEDIUM
          headline2: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w600),

          //GREEN TEXT
          headline3: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 18,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w500),

          // WHITE TEXT
          headline4: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w500),

          //BLACK TEXT
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "CenturyGothic",
          ),

          //BODY TEXT 1
          bodyText1: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 29,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w700),

          //BODY TEXT 2
          bodyText2: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 17,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w300),

          //BODY TEXT 3
          headline6: TextStyle(
              fontFamily: 'CenturyGothic',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )),
    //----------------------------------------------------
    darkOrLight.lightTheme: ThemeData(
        accentColor: Colors.blue,
        primaryColor: Color(0xFF8CD7AE),
        primaryColorDark: Colors.blue,
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Color(0xFF8CD7AE),
        textTheme: TextTheme(
          //HEADING LARGE
          headline1: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w700),
          //HEADING MEDIUM
          headline2: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w600),

          //GREEN TEXT
          headline3: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 18,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w500),
          // WHITE TEXT
          headline4: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w500),

          //BLACK TEXT
          headline5: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: "CenturyGothic",
          ),

          //BODY TEXT 1
          bodyText1: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 29,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w700),

          //BODY TEXT 2
          bodyText2: TextStyle(
              color: Color(0xFF8CD7AE),
              fontSize: 17,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.w300),

          //BODY TEXT 3
          headline6: TextStyle(
              fontFamily: 'CenturyGothic',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        )),
  };
}

enum darkOrLight { lightTheme, darkTheme }
