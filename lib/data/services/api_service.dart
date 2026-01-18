/// HTTP API Service (Data Layer)
/// 
/// This service handles all HTTP communication with the backend API.
/// It provides a centralized location for network operations, error handling,
/// and request/response processing.
/// 
/// Key responsibilities:
/// - Making HTTP requests (GET, POST, PUT, DELETE)
/// - Handling authentication headers and tokens
/// - Processing API responses and errors
/// - Converting HTTP exceptions to domain exceptions
/// - Managing request timeouts and retries
/// - Standardizing request/response formats
/// 
/// Features:
/// - Automatic JSON parsing and encoding
/// - Consistent error handling across all requests
/// - Network connectivity error detection
/// - HTTP status code interpretation
/// - Header management (authentication, content-type)
/// 
/// How to add new API methods:
/// 1. Create a public method for the specific operation
/// 2. Use the appropriate HTTP method (get, post, put, delete)
/// 3. Pass the request through _handleRequest for consistent error handling
/// 4. Return the parsed JSON response or throw appropriate exceptions
/// 
/// Example of adding new API methods:
/// ```dart
/// Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
///   return await _handleRequest(
///     http.post(
///       Uri.parse('$baseUrl/users'),
///       headers: _headers,
///       body: json.encode(userData),
///     ),
///   );
/// }
/// 
/// Future<List<Map<String, dynamic>>> getUsers({int page = 1, int limit = 20}) async {
///   final response = await _handleRequest(
///     http.get(
///       Uri.parse('$baseUrl/users?page=$page&limit=$limit'),
///       headers: _headers,
///     ),
///   );
///   return List<Map<String, dynamic>>.from(response['data']);
/// }
/// 
/// Future<void> deleteUser(String userId) async {
///   await _handleRequest(
///     http.delete(
///       Uri.parse('$baseUrl/users/$userId'),
///       headers: _headers,
///     ),
///   );
/// }
/// 
/// // File upload method
/// Future<Map<String, dynamic>> uploadFile(File file, String endpoint) async {
///   final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));
///   request.files.add(await http.MultipartFile.fromPath('file', file.path));
///   request.headers.addAll(_headers);
///   
///   final streamedResponse = await request.send();
///   final response = await http.Response.fromStream(streamedResponse);
///   
///   _handleHttpError(response);
///   return json.decode(response.body);
/// }
/// ```
/// 
/// Authentication setup:
/// ```dart
/// void setAuthToken(String token) {
///   _headers['Authorization'] = 'Bearer $token';
/// }
/// 
/// void clearAuthToken() {
///   _headers.remove('Authorization');
/// }
/// ```

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/errors/exceptions.dart';

class ApiService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  void _handleHttpError(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 400) {
      try {
        final data = json.decode(response.body);
        final message = data['message'] ?? 'Server error';
        throw ServerException('$message (Status: $statusCode)');
      } catch (e) {
        throw ServerException('Server error (Status: $statusCode)');
      }
    }
  }

  Future<Map<String, dynamic>> _handleRequest(Future<http.Response> requestFuture) async {
    try {
      final response = await requestFuture;
      _handleHttpError(response);
      return json.decode(response.body);
    } on SocketException {
      throw NetworkException('No internet connection');
    } on HttpException {
      throw NetworkException('Network error occurred');
    } catch (e) {
      if (e is ServerException || e is NetworkException) {
        rethrow;
      }
      throw UnknownException('An unexpected error occurred: $e');
    }
  }

  // Mock implementation for demonstration
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock response
    if (email == 'test@example.com' && password == 'password') {
      return {
        'user': {
          'id': '1',
          'name': 'Test User',
          'email': email,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'is_verified': true,
          'role': 'user',
        },
        'token': 'mock_jwt_token_12345'
      };
    } else {
      throw ServerException('Invalid credentials');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'user': {
        'id': '2',
        'name': name,
        'email': email,
        'phone': phone,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
        'is_verified': false,
        'role': 'user',
      },
      'token': 'mock_jwt_token_67890'
    };
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Mock logout - remove auth token
    removeAuthToken();
  }

  Future<Map<String, dynamic>> updateProfile({
    required String id,
    String? name,
    String? email,
    String? phone,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return {
      'id': id,
      'name': name ?? 'Updated User',
      'email': email ?? 'updated@example.com',
      'phone': phone,
      'created_at': DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
      'is_verified': true,
      'role': 'user',
    };
  }

  Future<Map<String, dynamic>> uploadAvatar(String filePath) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'avatar_url': 'https://example.com/avatars/mock_avatar.jpg'
    };
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock password change - would validate current password in real app
  }

  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock forgot password - would send email in real app
  }

  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock reset password - would validate token in real app
  }

  Future<Map<String, dynamic>> getUsers({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'data': [
        {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'is_verified': true,
          'role': 'user',
        },
        {
          'id': '2',
          'name': 'Jane Smith',
          'email': 'jane@example.com',
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'is_verified': true,
          'role': 'admin',
        },
      ],
      'meta': {
        'current_page': page,
        'per_page': limit,
        'total': 2,
      }
    };
  }

  Future<Map<String, dynamic>> getPosts({
    int page = 1,
    int limit = 20,
    String? search,
    List<String>? tags,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'data': [
        {
          'id': '1',
          'user_id': 1,
          'title': 'Clean Architecture in Flutter',
          'body': 'This is a comprehensive guide to implementing clean architecture.',
        },
        {
          'id': '2',
          'user_id': 2,
          'title': 'State Management with BLoC',
          'body': 'Learn how to manage state effectively using the BLoC pattern.',
        },
      ]
    };
  }

  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  void removeAuthToken() {
    _headers.remove('Authorization');
  }
}