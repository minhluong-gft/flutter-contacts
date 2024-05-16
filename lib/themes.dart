import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kLightColorSchema = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
final kLightTheme = ThemeData().copyWith(
  textTheme: GoogleFonts.inderTextTheme(),
  colorScheme: kLightColorSchema,
);

final kDarkColorSchema = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.dark,
);
final kDarkTheme = ThemeData.dark().copyWith(
  textTheme: GoogleFonts.inderTextTheme(),
  colorScheme: kDarkColorSchema,
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    isDense: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),
);
