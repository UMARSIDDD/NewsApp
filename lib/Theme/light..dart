// ignore: file_names
import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            iconColor: MaterialStateProperty.all<Color>(Colors.black))),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.teal,
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
        headlineMedium: TextStyle(color: Colors.amber),
        headlineSmall: TextStyle(color: Colors.green)),
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Colors.grey[100]!,
        secondary: Colors.grey[600]!),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)));
