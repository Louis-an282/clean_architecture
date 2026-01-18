/// Remote Data Source Interface and Implementation (Data Layer)
/// 
/// This file contains the remote data source abstraction and its concrete
/// implementation. It defines contracts for all remote API operations and
/// provides mock implementations for development/testing.
/// 
/// Architecture pattern:
/// - Interface segregation with abstract class defining contracts
/// - Concrete implementation with mock data for development
/// - Ready to be replaced with real API implementation
/// - Follows Dependency Inversion principle
/// 
/// Key responsibilities:
/// - Define contracts for all remote data operations
/// - Handle API communication and data fetching
/// - Convert raw API responses to model objects
/// - Throw appropriate exceptions for error cases
/// 
/// How to implement real API data source:
/// 1. Inject ApiService dependency into RemoteDataSourceImpl
/// 2. Replace mock implementations with actual API calls
/// 3. Handle error responses and convert to exceptions
/// 4. Parse JSON responses using model fromJson methods
/// 5. Add authentication headers and token management
/// 
/// Example of real implementation:
/// ```dart
/// class RemoteDataSourceImpl implements RemoteDataSource {
///   final ApiService _apiService;
/// 
///   RemoteDataSourceImpl(this._apiService);
/// 
///   @override
///   Future<List<UserModel>> getUsers() async {
///     try {
///       final response = await _apiService.get('/users');
///       final List<dynamic> data = response['data'];
///       return data.map((json) => UserModel.fromJson(json)).toList();
///     } catch (e) {
///       throw ServerException('Failed to fetch users: $e');
///     }
///   }
/// 
///   @override
///   Future<UserModel> loginUser(String email, String password) async {
///     try {
///       final response = await _apiService.post('/auth/login', {
///         'email': email,
///         'password': password,
///       });
///       return UserModel.fromJson(response['user']);
///     } catch (e) {
///       if (e.toString().contains('401')) {
///         throw AuthenticationException('Invalid credentials');
///       }
///       throw ServerException('Login failed: $e');
///     }
///   }
/// }
/// ```

import '../models/post_model.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
  Future<UserModel> loginUser(String email, String password);
  Future<void> logoutUser();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<UserModel>> getUsers() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    return [
      UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        role: 'user',
      ),
      UserModel(
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        role: 'user',
      ),
    ];
  }

  @override
  Future<UserModel> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isVerified: true,
      role: 'user',
    );
  }

  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    return [
      PostModel(
        id: '1',
        title: 'Clean Architecture in Flutter',
        content: 'This is a comprehensive guide to implementing clean architecture in Flutter applications with BLoC pattern.',
        authorId: '1',
        authorName: 'John Doe',
        tags: ['flutter', 'clean-architecture', 'bloc'],
        likesCount: 42,
        commentsCount: 8,
        isLiked: false,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'published',
      ),
      PostModel(
        id: '2',
        title: 'State Management Best Practices',
        content: 'Learn about different state management solutions and when to use each one in your Flutter projects.',
        authorId: '2',
        authorName: 'Jane Smith',
        tags: ['flutter', 'state-management', 'best-practices'],
        likesCount: 31,
        commentsCount: 5,
        isLiked: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        status: 'published',
      ),
    ];
  }

  @override
  Future<PostModel> getPostById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return PostModel(
      id: '1',
      title: 'Clean Architecture in Flutter',
      content: 'This is a comprehensive guide to implementing clean architecture in Flutter applications with BLoC pattern.',
      authorId: '1',
      authorName: 'John Doe',
      tags: ['flutter', 'clean-architecture', 'bloc'],
      likesCount: 42,
      commentsCount: 8,
      isLiked: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      status: 'published',
    );
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock authentication
    if (email == 'test@example.com' && password == 'password') {
      return UserModel(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isVerified: true,
        role: 'user',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<void> logoutUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Clear authentication tokens, etc.
  }
}