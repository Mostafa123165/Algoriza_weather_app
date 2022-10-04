import 'package:flutter/material.dart';

ThemeData lightTheme() => ThemeData(
  textTheme: const TextTheme(

    bodyText2:TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold
    ),
    subtitle1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme:  InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
        width: 0.5,
        color: Colors.white,
      )
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(
        width: 0.5,
        color: Colors.white
      )
    )
  )
);