/// Application Constants
/// 
/// This file contains all static constants used throughout the application.
/// Centralizing constants makes them easy to maintain and update.
/// 
/// Categories included:
/// - App metadata (name, version)
/// - Network settings (timeouts, URLs, API versions)
/// - Pagination and retry settings
/// - Storage keys for local data persistence
/// 
/// How to add new constants:
/// 1. Add them as static const fields in appropriate sections
/// 2. Use meaningful names that clearly describe their purpose
/// 3. Group related constants together
/// 4. Use appropriate data types (String, int, double, bool)
/// 
/// Example of adding new constants:
/// ```dart
/// // New section for cache settings
/// static const int cacheExpirationHours = 24;
/// static const int maxCacheSize = 50; // MB
/// 
/// // New API endpoints
/// static const String loginEndpoint = '/auth/login';
/// static const String refreshTokenEndpoint = '/auth/refresh';
/// ```

class AppConstants {
  static const String appName = 'Clean Architecture Demo';
  static const String appVersion = '1.0.0';
  
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  static const int pageSize = 20;
  static const int maxRetryAttempts = 3;
  
  static const String localStorageKey = 'app_local_storage';
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
}