/// Application Router and Route Generation
/// 
/// This class handles all route generation and navigation logic for the
/// application. It maps route names to their corresponding screen widgets
/// and provides a centralized location for navigation configuration.
/// 
/// Key responsibilities:
/// - Route generation based on route names and settings
/// - Parameter extraction from route settings
/// - Custom page transitions and animations
/// - Route guards and authentication checks
/// - Error handling for unknown routes
/// - Deep linking support
/// 
/// Architecture benefits:
/// - Centralized navigation logic
/// - Type-safe route generation
/// - Consistent page transitions
/// - Easy route parameter handling
/// - 404 error page support
/// 
/// How to add new routes:
/// 1. Add the route case to the generateRoute switch statement
/// 2. Import the corresponding screen widget
/// 3. Configure MaterialPageRoute with proper settings
/// 4. Add parameter extraction if needed
/// 5. Consider route guards for protected screens
/// 
/// Example of adding new routes:
/// ```dart
/// static Route<dynamic> generateRoute(RouteSettings settings) {
///   switch (settings.name) {
///     // Existing routes...
///     
///     case AppRoutes.productDetail:
///       final productId = settings.arguments as String?;
///       if (productId == null) {
///         return _errorRoute('Product ID required');
///       }
///       return MaterialPageRoute(
///         builder: (_) => ProductDetailScreen(productId: productId),
///         settings: settings,
///       );
/// 
///     case AppRoutes.checkout:
///       return PageRouteBuilder(
///         builder: (_) => const CheckoutScreen(),
///         settings: settings,
///         pageBuilder: (context, animation, secondaryAnimation) => 
///           const CheckoutScreen(),
///         transitionsBuilder: (context, animation, secondaryAnimation, child) {
///           return SlideTransition(
///             position: animation.drive(
///               Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
///             ),
///             child: child,
///           );
///         },
///       );
/// 
///     case AppRoutes.adminDashboard:
///       // Route guard example
///       if (!_isUserAdmin()) {
///         return MaterialPageRoute(
///           builder: (_) => const UnauthorizedScreen(),
///           settings: settings,
///         );
///       }
///       return MaterialPageRoute(
///         builder: (_) => const AdminDashboardScreen(),
///         settings: settings,
///       );
/// 
///     // Parameterized route example
///     default:
///       if (settings.name?.startsWith('/user/') == true) {
///         final userId = settings.name!.split('/')[2];
///         return MaterialPageRoute(
///           builder: (_) => UserProfileScreen(userId: userId),
///           settings: settings,
///         );
///       }
///       return _errorRoute();
///   }
/// }
/// 
/// static Route<dynamic> _errorRoute([String? message]) {
///   return MaterialPageRoute(
///     builder: (_) => NotFoundScreen(message: message),
///     settings: const RouteSettings(name: '/error'),
///   );
/// }
/// 
/// static bool _isUserAdmin() {
///   // Check user role from authentication service
///   return false; // Implement actual logic
/// }
/// ```
/// 
/// Custom transitions:
/// ```dart
/// static Route<dynamic> _createSlideRoute(Widget screen, RouteSettings settings) {
///   return PageRouteBuilder(
///     settings: settings,
///     pageBuilder: (context, animation, _) => screen,
///     transitionsBuilder: (context, animation, secondaryAnimation, child) {
///       const begin = Offset(1.0, 0.0);
///       const end = Offset.zero;
///       const curve = Curves.ease;
/// 
///       var tween = Tween(begin: begin, end: end).chain(
///         CurveTween(curve: curve),
///       );
/// 
///       return SlideTransition(
///         position: animation.drive(tween),
///         child: child,
///       );
///     },
///   );
/// }
/// ```

import 'package:flutter/material.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/posts/posts_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case AppRoutes.posts:
        return MaterialPageRoute(
          builder: (_) => const PostsScreen(),
          settings: settings,
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
          settings: settings,
        );
    }
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}