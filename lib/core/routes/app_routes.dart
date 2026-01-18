/// Application Route Constants
/// 
/// This file centralizes all route path definitions used throughout the
/// application. It provides a single source of truth for navigation paths,
/// making route management easier and preventing typos in navigation code.
/// 
/// Route organization:
/// - Authentication routes (splash, login, register, forgot password)
/// - Main app routes (home, profile, settings)
/// - Feature-specific routes (posts, notifications)
/// - Parameterized routes with dynamic segments
/// 
/// Benefits:
/// - Centralized route management
/// - Type-safe navigation with constants
/// - Easy route refactoring and updates
/// - Consistent naming conventions
/// - Support for parameterized routes
/// 
/// How to add new routes:
/// 1. Add route constants following the naming pattern
/// 2. Use descriptive names that match screen functionality
/// 3. Group related routes together
/// 4. Add parameterized versions when needed
/// 5. Update the AppRouter to handle new routes
/// 
/// Example of adding new routes:
/// ```dart
/// class AppRoutes {
///   // Existing routes...
///   
///   // E-commerce routes
///   static const String shop = '/shop';
///   static const String productDetail = '/product-detail';
///   static const String cart = '/cart';
///   static const String checkout = '/checkout';
///   static const String orderHistory = '/order-history';
///   
///   // Parameterized routes
///   static const String productDetailWithId = '/product-detail/:productId';
///   static const String categoryProducts = '/category/:categoryId/products';
///   static const String orderDetail = '/order/:orderId';
///   
///   // Settings and preferences
///   static const String accountSettings = '/settings/account';
///   static const String privacySettings = '/settings/privacy';
///   static const String paymentMethods = '/settings/payment';
///   
///   // Help and support
///   static const String help = '/help';
///   static const String contactSupport = '/support';
///   static const String faq = '/faq';
///   
///   // Admin routes (if applicable)
///   static const String adminDashboard = '/admin';
///   static const String userManagement = '/admin/users';
///   static const String analytics = '/admin/analytics';
/// }
/// ```
/// 
/// Route parameter handling:
/// ```dart
/// // Navigate with parameters
/// context.pushNamed(
///   AppRoutes.productDetailWithId.replaceAll(':productId', productId),
/// );
/// 
/// // Or using go_router:
/// context.goNamed('product-detail', pathParameters: {'productId': productId});
/// 
/// // Extract parameters in route handler
/// final productId = routeData.pathParameters['productId'];
/// ```
/// 
/// Usage with navigation:
/// ```dart
/// // Using Navigator
/// Navigator.pushNamed(context, AppRoutes.home);
/// 
/// // Using go_router
/// context.go(AppRoutes.home);
/// 
/// // Using custom navigation service
/// NavigationService.navigateTo(AppRoutes.profile);
/// ```

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String posts = '/posts';
  static const String postDetail = '/post-detail';
  static const String createPost = '/create-post';
  static const String settings = '/settings';
  static const String notifications = '/notifications';

  static const String postDetailWithId = '/post-detail/:id';
  static const String userProfile = '/user/:userId';
}