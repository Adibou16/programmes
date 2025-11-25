import 'package:flutter/material.dart';
import 'package:programmes/themes/theme_constants.dart';
import 'package:programmes/themes/theme_extensions.dart';


// LIGHT MODE
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, 

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: AppThemeValues.xLargeFont,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    headlineMedium: TextStyle(
      fontSize: AppThemeValues.largeFont,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),

    bodyLarge: TextStyle(
      fontSize: AppThemeValues.largeFont,
      color: Colors.black,
    ),

    bodyMedium: TextStyle(
      fontSize: AppThemeValues.mediumFont,
      color: Colors.black,
    ),

    bodySmall: TextStyle(
      fontSize: AppThemeValues.smallFont,
      color: Colors.black,
    ),
  ),

  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.grey.shade300, 
    foregroundColor: Colors.black,
    titleTextStyle: const TextStyle(
      color: Colors.black,        
      fontSize: AppThemeValues.largeFont,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
  ),


  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade300,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey.shade800
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade200,
    contentTextStyle: const TextStyle(color: Colors.black),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey.shade300,
    titleTextStyle: const TextStyle(
      color: Colors.black, 
      fontWeight: FontWeight.bold,
      fontSize: AppThemeValues.largeFont,
    ),
    contentTextStyle: const TextStyle(color: Colors.black)
  ),

  cardTheme: CardTheme(
    color: Colors.grey.shade300,
    surfaceTintColor: Colors.transparent
  ),

  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400, 
    primary: Colors.blue,
  ),
  
  extensions: [
    AppColors(
      header: Colors.grey.shade800,
      text: Colors.grey.shade700,
      border: Colors.grey.shade900,
    ),
  ],
);


// DARK MODE
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: AppThemeValues.xLargeFont,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    headlineMedium: TextStyle(
      fontSize: AppThemeValues.largeFont,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),

    bodyLarge: TextStyle(
      fontSize: AppThemeValues.largeFont,
      color: Colors.white,
    ),

    bodyMedium: TextStyle(
      fontSize: AppThemeValues.mediumFont,
      color: Colors.white,
    ),

    bodySmall: TextStyle(
      fontSize: AppThemeValues.smallFont,
      color: Colors.white,
    ),
  ), 

  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.grey.shade900, 
    foregroundColor: Colors.white, 
    titleTextStyle: const TextStyle(
      color: Colors.white,        
      fontSize: AppThemeValues.largeFont,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey.shade900, 
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey.shade300
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    contentTextStyle: const TextStyle(color: Colors.white),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey.shade900,
    titleTextStyle: const TextStyle(
      color: Colors.white, 
      fontWeight: FontWeight.bold,
      fontSize: AppThemeValues.largeFont,
    ),
    contentTextStyle: const TextStyle(color: Colors.white)
  ),

  cardTheme: CardTheme(
    color: Colors.grey.shade900,
    surfaceTintColor: Colors.transparent
  ),

  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, 
    primary: Colors.blue,
    error: Colors.redAccent
  ),

  extensions: [
    AppColors(
      header: Colors.grey.shade300,
      text: Colors.grey.shade200,
      border: Colors.grey.shade700,
    ),
  ],
);