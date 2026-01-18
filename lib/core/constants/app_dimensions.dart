/// Application UI Dimensions and Spacing Constants
/// 
/// This file centralizes all spacing, sizing, and dimensional constants used
/// throughout the UI. It follows a consistent sizing scale (XS, S, M, L, XL)
/// to ensure visual consistency across the application.
/// 
/// Categories included:
/// - Padding constants for internal spacing
/// - Margin constants for external spacing  
/// - Border radius values for rounded corners
/// - Elevation values for material design depth
/// - Icon sizes for consistent iconography
/// - Button and component heights
/// - Legacy aliases for backward compatibility
/// 
/// How to add new dimensions:
/// 1. Choose the appropriate category (padding, margin, etc.)
/// 2. Follow the sizing scale: XS (4), S (8), M (16), L (24), XL (32+)
/// 3. Use descriptive names that indicate purpose
/// 4. Add comments for special-purpose dimensions
/// 
/// Example of adding new dimensions:
/// ```dart
/// // Text field dimensions
/// static const double textFieldHeight = 48.0;
/// static const double textFieldBorderWidth = 1.0;
/// 
/// // Card dimensions
/// static const double cardMinHeight = 120.0;
/// static const double cardMaxWidth = 400.0;
/// 
/// // Animation dimensions
/// static const double swipeThreshold = 100.0;
/// ```
/// 
/// Usage patterns:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppDimensions.paddingM),
///   child: Container(
///     decoration: BoxDecoration(
///       borderRadius: BorderRadius.circular(AppDimensions.radiusM),
///       boxShadow: [
///         BoxShadow(blurRadius: AppDimensions.elevationM),
///       ],
///     ),
///   ),
/// )
/// ```

class AppDimensions {
  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  // Margins
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  
  // Border radius
  static const double radiusXS = 2.0;
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusCircular = 50.0;
  
  // Elevation
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;
  
  // Icon sizes
  static const double iconXS = 12.0;
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Button heights
  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  static const double buttonHeight = 48.0;  // default button height
  
  // Component heights
  static const double appBarHeight = 56.0;
  static const double tabBarHeight = 48.0;
  static const double bottomNavHeight = 60.0;
  
  // Legacy aliases for backward compatibility
  static const double defaultPadding = 16.0;  // alias for paddingM
  static const double smallPadding = 8.0;     // alias for paddingS
  static const double largePadding = 24.0;    // alias for paddingL
  static const double defaultMargin = 16.0;   // alias for marginM
  static const double smallMargin = 8.0;      // alias for marginS
  static const double largeMargin = 24.0;     // alias for marginL
  
  // Other dimensions
  static const double cardElevation = 2.0;
  static const double dividerHeight = 1.0;
  static const double progressHeight = 4.0;
  static const double defaultRadius = 8.0;  // default border radius
  static const double defaultElevation = 2.0;  // default elevation
}