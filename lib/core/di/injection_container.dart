/// Dependency Injection Container Setup
/// 
/// This file configures all dependencies for the application using GetIt service locator.
/// It follows the Clean Architecture pattern by registering dependencies in layers:
/// - Presentation Layer: BLoCs and UI-related services
/// - Domain Layer: Use cases and repositories (interfaces)
/// - Data Layer: Repository implementations, data sources, and services
/// 
/// How to add new dependencies:
/// 1. Import the classes you want to register
/// 2. Register them in the appropriate section based on their layer
/// 3. Use appropriate registration methods:
///    - registerFactory(): Creates new instance each time (for BLoCs)
///    - registerLazySingleton(): Creates singleton on first access (for services)
///    - registerSingleton(): Creates singleton immediately
/// 
/// Example of adding a new service:
/// ```dart
/// // In services section:
/// sl.registerLazySingleton<DatabaseService>(() => DatabaseService());
/// 
/// // In repositories section:
/// sl.registerLazySingleton<PostRepository>(
///   () => PostRepositoryImpl(
///     remoteDataSource: sl(),
///     localDataSource: sl(),
///   ),
/// );
/// 
/// // In BLoCs section:
/// sl.registerFactory(() => PostsBloc(postRepository: sl()));
/// ```

import 'package:get_it/get_it.dart';
import '../../data/datasources/local_data_source.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/api_service.dart';
import '../../data/services/local_storage_service.dart';
import '../../data/services/notification_service.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/posts/posts_bloc.dart';

/// Service Locator instance - used to register and retrieve dependencies
final sl = GetIt.instance;

/// Initialize all application dependencies
/// Call this method in main.dart before runApp()
Future<void> init() async {
  // BLoCs
  sl.registerFactory(() => AuthBloc(userRepository: sl()));
  sl.registerFactory(() => PostsBloc());

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // Services
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());

  // External dependencies would go here
  // For example: HTTP client, shared preferences, etc.
}