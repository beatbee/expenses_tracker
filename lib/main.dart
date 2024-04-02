import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255,96,59,181),);
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        //useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.all(16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kColorScheme.primaryContainer),
            foregroundColor: MaterialStateProperty.all<Color>(kColorScheme.onPrimaryContainer),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
         titleLarge: TextStyle(fontWeight: FontWeight.normal, color: kColorScheme.onSecondaryContainer,
         fontSize: 20),
         
        )
      ),  
      home: const Expenses(),
    ),
  );
}

