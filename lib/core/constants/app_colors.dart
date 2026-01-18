/// Application Color Palette and Theme Colors
/// 
/// This file defines the complete color system used throughout the application.
/// It ensures visual consistency and provides a centralized location for
/// managing the app's color scheme, supporting both light and dark themes.
/// 
/// Color organization:
/// - Primary brand colors and variations
/// - Secondary accent colors
/// - Background and surface colors for layouts
/// - Text colors with proper contrast ratios
/// - Status colors for feedback (success, warning, error, info)
/// - Border, divider, and shadow colors
/// - Gradient definitions for enhanced visuals
/// 
/// Benefits:
/// - Consistent color usage across the entire app
/// - Easy theme switching and customization
/// - Accessibility support with proper contrast
/// - Simplified maintenance when updating brand colors
/// 
/// How to add new colors:
/// 1. Group new colors by purpose (branding, UI, status, etc.)
/// 2. Use descriptive names that indicate usage context
/// 3. Ensure proper contrast ratios for accessibility
/// 4. Include color variations (light, dark) when needed
/// 5. Add aliases for backward compatibility if renaming
/// 
/// Example of adding new color categories:
/// ```dart
/// // Dark theme colors
/// static const Color darkBackground = Color(0xFF121212);
/// static const Color darkSurface = Color(0xFF1E1E1E);
/// static const Color darkTextPrimary = Color(0xFFFFFFFF);
/// 
/// // Feature-specific colors
/// static const Color chatBubbleSent = Color(0xFF2196F3);
/// static const Color chatBubbleReceived = Color(0xFFE0E0E0);
/// static const Color onlineStatus = Color(0xFF4CAF50);
/// static const Color offlineStatus = Color(0xFF9E9E9E);
/// 
/// // Interactive element colors
/// static const Color buttonPressed = Color(0xFF1976D2);
/// static const Color linkColor = Color(0xFF1976D2);
/// static const Color selectionColor = Color(0x332196F3);
/// ```
/// 
/// Usage in widgets:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text(
///     'Hello',
///     style: TextStyle(color: AppColors.textPrimary),
///   ),
/// )
/// ```

import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryColor = Color(0xFF2196F3);  // alias for primary
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFBBDEFB);
  
  // Secondary colors
  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryDark = Color(0xFFF57C00);
  static const Color secondaryLight = Color(0xFFFFE0B2);
  
  // Background and surface colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundColor = Color(0xFFF5F5F5);  // alias for background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);  // alias for card
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color errorColor = Color(0xFFF44336);  // alias for error
  static const Color info = Color(0xFF2196F3);
  
  // Border and divider colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
  
  // Gradient colors
  static const Color gradientStart = Color(0xFF2196F3);
  static const Color gradientEnd = Color(0xFF21CBF3);
}