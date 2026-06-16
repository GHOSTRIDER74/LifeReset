import 'package:flutter/material.dart';

class AppColors {
  // Private constructor — prevents instantiation (this is a utility class)
  AppColors._();

  static const Color background    = Color(0xFF000000); // Pure black
  static const Color surface       = Color(0xFF1A1A1A); // Cards, sheets, inputs
  static const Color orange        = Color(0xFFE8560A); // CTAs, highlights, accents
  static const Color textPrimary   = Color(0xFFFFFFFF); // Headlines, body
  static const Color textSecondary = Color(0xFF888888); // Hints, captions, labels
}

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    // ── Canvas ──────────────────────────────────────────────
    scaffoldBackgroundColor: AppColors.background,

    // ── Cards & Surfaces ────────────────────────────────────
    cardColor: AppColors.surface,
    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
    ),

    // ── Color Scheme (drives Material 3 components) ─────────
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.orange,        // Buttons, FABs, checkboxes
      onPrimary: AppColors.textPrimary, // Text ON orange backgrounds
      onSurface: AppColors.textPrimary, // Text on cards
      outline: AppColors.textSecondary, // Borders, dividers
    ),

    // ── Typography ──────────────────────────────────────────
    textTheme: const TextTheme(
      bodyLarge:  TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textPrimary),
      bodySmall:  TextStyle(color: AppColors.textSecondary),
      titleLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
    ),

    // ── App Bar ─────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),

    // ── Buttons ─────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.textPrimary,
      ),
    ),

    // ── Input Fields ────────────────────────────────────────
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hintStyle: TextStyle(color: AppColors.textSecondary),
      border: OutlineInputBorder(borderSide: BorderSide.none),
    ),
  );
}