/// Application Theme Configuration
/// 
/// This file defines the complete visual theme system for the application,
/// including light and dark theme variants. It centralizes all styling
/// decisions and ensures consistent visual appearance across the entire app.
/// 
/// Theme components configured:
/// - Material Design 3 integration with custom color schemes
/// - AppBar styling with elevation and typography
/// - Card components with shadows and border radius
/// - Button themes (Elevated, Outlined, Text buttons)
/// - Input field styling and states
/// - SnackBar and dialog theming
/// - Bottom sheet and modal styling
/// 
/// Benefits:
/// - Consistent visual design across all screens
/// - Easy theme switching (light/dark mode)
/// - Centralized style management
/// - Material Design 3 compliance
/// - Accessibility support with proper contrast
/// - Easy customization and brand updates
/// 
/// How to add new theme components:
/// 1. Add the component theme to both lightTheme and darkTheme
/// 2. Use AppColors and AppDimensions constants for consistency
/// 3. Ensure proper accessibility contrast ratios
/// 4. Test both light and dark variants
/// 5. Consider Material Design 3 guidelines
/// 
/// Example of adding new theme components:
/// ```dart
/// static ThemeData lightTheme = ThemeData(
///   // Existing configuration...
///   
///   // Add new component themes
///   chipTheme: ChipThemeData(
///     backgroundColor: AppColors.surface,
///     selectedColor: AppColors.primary,
///     labelStyle: TextStyle(color: AppColors.textPrimary),
///     shape: RoundedRectangleBorder(
///       borderRadius: BorderRadius.circular(AppDimensions.radiusS),
///     ),
///   ),
///   
///   tabBarTheme: TabBarTheme(
///     labelColor: AppColors.primary,
///     unselectedLabelColor: AppColors.textSecondary,
///     indicator: UnderlineTabIndicator(
///       borderSide: BorderSide(color: AppColors.primary, width: 2),
///     ),
///   ),
///   
///   floatingActionButtonTheme: FloatingActionButtonThemeData(
///     backgroundColor: AppColors.primary,
///     foregroundColor: Colors.white,
///     elevation: AppDimensions.elevationM,
///     shape: RoundedRectangleBorder(
///       borderRadius: BorderRadius.circular(AppDimensions.radiusL),
///     ),
///   ),
///   
///   listTileTheme: ListTileThemeData(
///     tileColor: AppColors.surface,
///     selectedTileColor: AppColors.primaryLight,
///     shape: RoundedRectangleBorder(
///       borderRadius: BorderRadius.circular(AppDimensions.radiusS),
///     ),
///   ),
/// );
/// ```
/// 
/// Custom theme extensions:
/// ```dart
/// @immutable
/// class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
///   final Color customColor;
///   final TextStyle customTextStyle;
/// 
///   const CustomThemeExtension({
///     required this.customColor,
///     required this.customTextStyle,
///   });
/// 
///   @override
///   CustomThemeExtension copyWith({Color? customColor, TextStyle? customTextStyle}) {
///     return CustomThemeExtension(
///       customColor: customColor ?? this.customColor,
///       customTextStyle: customTextStyle ?? this.customTextStyle,
///     );
///   }
/// 
///   @override
///   CustomThemeExtension lerp(ThemeExtension<CustomThemeExtension>? other, double t) {
///     if (other is! CustomThemeExtension) return this;
///     return CustomThemeExtension(
///       customColor: Color.lerp(customColor, other.customColor, t)!,
///       customTextStyle: TextStyle.lerp(customTextStyle, other.customTextStyle, t)!,
///     );
///   }
/// }
/// ```
/// 
/// Usage in widgets:
/// ```dart
/// // Access theme data
/// final theme = Theme.of(context);
/// final colorScheme = theme.colorScheme;
/// 
/// // Use themed components
/// ElevatedButton(onPressed: () {}, child: Text('Themed Button'))
/// 
/// // Custom theme extension usage
/// final customTheme = Theme.of(context).extension<CustomThemeExtension>();
/// ```

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingS,
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingM,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.textPrimary,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusL),
        ),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
    ),
  );
}