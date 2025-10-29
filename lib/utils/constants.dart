
import 'package:flutter/material.dart';

/// ---------------------------------------------------------
/// APP CONSTANTS (Colors, Typography, Spacing)
/// ---------------------------------------------------------
class AppColors {
  static const Color primary = Color(0xFF6366F1);   // Indigo
  static const Color secondary = Color(0xFF10B981); // Green
  static const Color accent = Color(0xFFEC4899);    // Pink
  static const Color warning = Color(0xFFF59E0B);   // Amber
  static const Color error = Color(0xFFF43F5E);     // Rose
  static const Color backgroundLight = Color(0xFFF3F4F6); // Gray 100
  static const Color borderColor = Color(0xFFE5E7EB); // Gray 200
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
}

/// ---------------------------------------------------------
/// TEXT STYLES
/// ---------------------------------------------------------
class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

/// ---------------------------------------------------------
/// SPACING CONSTANTS
/// ---------------------------------------------------------
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}
