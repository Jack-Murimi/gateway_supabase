import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(centerTitle: true),
  colorScheme: const ColorScheme.highContrastLight(),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(centerTitle: true),
  colorScheme: ColorScheme.highContrastDark(
    primary: Colors.orange.shade800,
  ),
  useMaterial3: true,
);
