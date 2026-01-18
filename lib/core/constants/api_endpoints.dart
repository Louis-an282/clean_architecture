/// API Endpoints Configuration
/// 
/// This file centralizes all API endpoint paths used throughout the application.
/// It provides a single source of truth for API URLs, making maintenance and
/// updates easier when backend endpoints change.
/// 
/// Organization strategy:
/// - Group endpoints by feature/domain (auth, users, posts, etc.)
/// - Use descriptive constant names that match their functionality
/// - Include path parameters using {id} placeholder syntax
/// - Separate base URL for easy environment switching
/// 
/// How to add new endpoints:
/// 1. Group new endpoints with related functionality
/// 2. Use consistent naming conventions (noun for resources, verb for actions)
/// 3. Include path parameters using {parameter} syntax
/// 4. Add comments for complex endpoint groups
/// 
/// Example of adding new feature endpoints:
/// ```dart
/// // Product management endpoints
/// static const String products = '/products';
/// static const String productById = '/products/{id}';
/// static const String productsByCategory = '/products/category/{categoryId}';
/// static const String createProduct = '/products';
/// static const String updateProduct = '/products/{id}';
/// static const String deleteProduct = '/products/{id}';
/// static const String searchProducts = '/products/search';
/// 
/// // File upload endpoints  
/// static const String uploadImage = '/upload/image';
/// static const String uploadDocument = '/upload/document';
/// ```
/// 
/// Usage patterns:
/// ```dart
/// // Simple endpoint
/// final url = ApiEndpoints.baseUrl + ApiEndpoints.login;
/// 
/// // With path parameters
/// final url = ApiEndpoints.baseUrl + 
///             ApiEndpoints.userById.replaceAll('{id}', userId);
/// ```

class ApiEndpoints {
  static const String baseUrl = 'https://api.example.com/v1';
  
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String uploadAvatar = '/user/avatar';
  
  static const String users = '/users';
  static const String userById = '/users/{id}';
  static const String createUser = '/users';
  static const String updateUser = '/users/{id}';
  static const String deleteUser = '/users/{id}';
  
  static const String posts = '/posts';
  static const String postById = '/posts/{id}';
  static const String createPost = '/posts';
  static const String updatePost = '/posts/{id}';
  static const String deletePost = '/posts/{id}';
  static const String postComments = '/posts/{id}/comments';
  
  static const String comments = '/comments';
  static const String commentById = '/comments/{id}';
  static const String createComment = '/comments';
  static const String updateComment = '/comments/{id}';
  static const String deleteComment = '/comments/{id}';
  
  static const String notifications = '/notifications';
  static const String markNotificationAsRead = '/notifications/{id}/read';
  static const String markAllNotificationsAsRead = '/notifications/read-all';
}