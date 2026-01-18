/// Main Application Entry Point
/// 
/// This file bootstraps the entire Flutter application following Clean Architecture
/// principles. It demonstrates proper dependency injection setup, BLoC state management
/// configuration, and application-level concerns.
/// 
/// Key responsibilities:
/// - Initialize Flutter framework bindings
/// - Setup dependency injection container
/// - Configure global BLoC providers
/// - Setup routing and navigation
/// - Configure app theme and appearance
/// - Handle application-level error boundaries
/// 
/// Architecture setup:
/// - Dependency Injection: Uses GetIt service locator pattern
/// - State Management: BLoC pattern with MultiBlocProvider
/// - Routing: Custom router with route generation
/// - Theming: Light/dark theme support with system detection
/// - Navigation: Global navigation service for programmatic navigation
/// 
/// Initialization flow:
/// 1. Ensure Flutter bindings are initialized
/// 2. Setup dependency injection (repositories, services, BLoCs)
/// 3. Run the app with proper BLoC providers
/// 4. Configure MaterialApp with routing and theming
/// 
/// How to add new global configurations:
/// 1. Add initialization code in main() before runApp()
/// 2. Add new BLoC providers to MultiBlocProvider
/// 3. Configure new services in dependency injection
/// 4. Setup global app settings in MaterialApp
/// 
/// Example of adding new global features:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   // Initialize dependency injection
///   await di.init();
///   
///   // Setup crash reporting
///   await FirebaseCrashlytics.instance.initializeApp();
///   
///   // Setup push notifications
///   await NotificationService.initialize();
///   
///   // Setup analytics
///   await AnalyticsService.initialize();
///   
///   runApp(const MyApp());
/// }
/// 
/// // Add new BLoC providers:
/// MultiBlocProvider(
///   providers: [
///     // Existing providers...
///     BlocProvider<NotificationBloc>(
///       create: (context) => di.sl<NotificationBloc>(),
///     ),
///     BlocProvider<ThemeBloc>(
///       create: (context) => di.sl<ThemeBloc>(),
///     ),
///   ],
///   // ...
/// )
/// ```
/// 
/// Global error handling:
/// ```dart
/// void main() async {
///   // Setup global error handling
///   FlutterError.onError = (FlutterErrorDetails details) {
///     FirebaseCrashlytics.instance.recordFlutterError(details);
///   };
///   
///   runZonedGuarded(() async {
///     // App initialization...
///     runApp(const MyApp());
///   }, (error, stackTrace) {
///     FirebaseCrashlytics.instance.recordError(error, stackTrace);
///   });
/// }
/// ```

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_themes.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/navigation_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/posts/posts_bloc.dart';

/// Application entry point
/// Initializes all dependencies and runs the Flutter app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await di.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => di.sl<PostsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Architecture Demo',
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}