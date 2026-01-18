/// Global Navigation Service
/// 
/// This service provides a global navigation interface that can be used
/// throughout the application without requiring a BuildContext. It's
/// particularly useful for navigation from business logic layers, services,
/// or anywhere outside the widget tree.
/// 
/// Key features:
/// - Context-free navigation using global navigator key
/// - Comprehensive navigation methods (push, replace, pop, etc.)
/// - Utility methods for dialogs, bottom sheets, and snack bars
/// - Stack management and navigation guards
/// - Type-safe navigation with generic support
/// 
/// Architecture benefits:
/// - Enables navigation from non-UI layers (BLoCs, repositories, services)
/// - Centralized navigation utilities
/// - Consistent UX patterns across the app
/// - Easy testing with navigation mocking
/// 
/// How to add new navigation utilities:
/// 1. Add static methods following the existing pattern
/// 2. Use the global navigator key for context access
/// 3. Provide sensible defaults for parameters
/// 4. Include proper error handling
/// 5. Support generic types for type-safe returns
/// 
/// Example of adding new navigation methods:
/// ```dart
/// class NavigationService {
///   // Existing methods...
///   
///   // Conditional navigation
///   static Future<T?> pushIfNotCurrent<T extends Object?>(String routeName) {
///     final currentRoute = ModalRoute.of(context!)?.settings.name;
///     if (currentRoute != routeName) {
///       return pushNamed<T>(routeName);
///     }
///     return Future.value(null);
///   }
///   
///   // Nested navigation
///   static Future<T?> pushToNestedNavigator<T extends Object?>(
///     GlobalKey<NavigatorState> nestedNavigatorKey,
///     String routeName, {
///     Object? arguments,
///   }) {
///     return nestedNavigatorKey.currentState!.pushNamed<T>(
///       routeName,
///       arguments: arguments,
///     );
///   }
///   
///   // Custom page transitions
///   static Future<T?> pushWithSlideTransition<T extends Object?>(
///     Widget page, {
///     Offset beginOffset = const Offset(1.0, 0.0),
///     Duration duration = const Duration(milliseconds: 300),
///   }) {
///     return navigator!.push<T>(
///       PageRouteBuilder<T>(
///         pageBuilder: (context, animation, _) => page,
///         transitionsBuilder: (context, animation, secondaryAnimation, child) {
///           return SlideTransition(
///             position: Tween<Offset>(
///               begin: beginOffset,
///               end: Offset.zero,
///             ).animate(animation),
///             child: child,
///           );
///         },
///         transitionDuration: duration,
///       ),
///     );
///   }
///   
///   // Alert dialogs
///   static Future<bool?> showConfirmDialog({
///     required String title,
///     required String content,
///     String confirmText = 'Confirm',
///     String cancelText = 'Cancel',
///   }) {
///     return showDialog<bool>(
///       context: context!,
///       builder: (context) => AlertDialog(
///         title: Text(title),
///         content: Text(content),
///         actions: [
///           TextButton(
///             onPressed: () => Navigator.of(context).pop(false),
///             child: Text(cancelText),
///           ),
///           ElevatedButton(
///             onPressed: () => Navigator.of(context).pop(true),
///             child: Text(confirmText),
///           ),
///         ],
///       ),
///     );
///   }
///   
///   // Loading overlay
///   static OverlayEntry? _loadingOverlay;
///   
///   static void showLoadingOverlay() {
///     if (_loadingOverlay != null) return;
///     
///     _loadingOverlay = OverlayEntry(
///       builder: (context) => Material(
///         color: Colors.black54,
///         child: Center(
///           child: CircularProgressIndicator(),
///         ),
///       ),
///     );
///     
///     Overlay.of(context!)?.insert(_loadingOverlay!);
///   }
///   
///   static void hideLoadingOverlay() {
///     _loadingOverlay?.remove();
///     _loadingOverlay = null;
///   }
/// }
/// ```
/// 
/// Usage examples:
/// ```dart
/// // From BLoC or service
/// NavigationService.pushNamed('/home');
/// NavigationService.showSnackBar('Login successful');
/// 
/// // From anywhere in the app
/// final result = await NavigationService.showBottomSheet(
///   child: SettingsBottomSheet(),
/// );
/// 
/// // Conditional navigation
/// if (user.isAuthenticated) {
///   NavigationService.pushNamedAndClearStack('/home');
/// } else {
///   NavigationService.pushReplacementNamed('/login');
/// }
/// ```
/// 
/// Setup in main.dart:
/// ```dart
/// MaterialApp(
///   navigatorKey: NavigationService.navigatorKey,
///   // other configurations...
/// )
/// ```

import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;
  static BuildContext? get context => navigatorKey.currentContext;

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndClearStack<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return navigator!.pop<T>(result);
  }

  static void popUntil(String routeName) {
    return navigator!.popUntil(ModalRoute.withName(routeName));
  }

  static bool canPop() {
    return navigator!.canPop();
  }

  static Future<bool> maybePop<T extends Object?>([T? result]) {
    return navigator!.maybePop<T>(result);
  }

  static void showSnackBar(String message, {bool isError = false}) {
    final messenger = ScaffoldMessenger.of(context!);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context!,
      builder: (context) => child,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  static Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context!,
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
    );
  }
}