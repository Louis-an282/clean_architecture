/// User Repository Implementation (Data Layer)
/// 
/// This class implements the UserRepository interface from the domain layer.
/// It serves as a bridge between the domain layer and data sources, handling:
/// - Data fetching from remote APIs and local cache
/// - Error handling and exception conversion
/// - Data caching strategies and offline support
/// - Coordination between multiple data sources
/// 
/// Architecture pattern:
/// - Implements domain repository interface (follows Dependency Inversion)
/// - Depends on data source abstractions, not concrete implementations
/// - Handles business logic related to data access and caching
/// 
/// How to add new repository methods:
/// 1. Add the method signature to the domain repository interface first
/// 2. Implement the method here following this pattern:
///    - Try remote data source first (for fresh data)
///    - Handle caching (save successful remote results to local)
///    - Implement fallback to local data if remote fails
///    - Convert exceptions to domain-appropriate types
/// 
/// Example of adding a new method:
/// ```dart
/// @override
/// Future<UserEntity> getUserProfile(String userId) async {
///   try {
///     // Try remote first
///     final userModel = await remoteDataSource.getUserProfile(userId);
///     await localDataSource.cacheUser(userModel);
///     return userModel;
///   } on NetworkException {
///     // Fallback to local cache
///     try {
///       return await localDataSource.getCachedUser(userId);
///     } catch (e) {
///       throw CacheException('No cached user data available');
///     }
///   } catch (e) {
///     throw ServerException('Failed to get user profile: ${e.toString()}');
///   }
/// }
/// ```

import '../../core/errors/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.loginUser(email, password);
      await localDataSource.cacheUser(userModel);
      return userModel;
    } catch (e) {
      throw ServerException('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logoutUser();
      await localDataSource.clearCache();
    } catch (e) {
      throw ServerException('Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await localDataSource.getCachedUser();
    } catch (e) {
      throw CacheException('Failed to get cached user: ${e.toString()}');
    }
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final userModels = await remoteDataSource.getUsers();
      return userModels;
    } catch (e) {
      throw ServerException('Failed to get users: ${e.toString()}');
    }
  }

  @override
  Future<UserEntity> getUserById(int id) async {
    try {
      final userModel = await remoteDataSource.getUserById(id);
      return userModel;
    } catch (e) {
      throw ServerException('Failed to get user by id: ${e.toString()}');
    }
  }
}