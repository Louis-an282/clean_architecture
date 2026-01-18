/// Custom Exception Classes for Clean Architecture
/// 
/// This file contains all custom exception classes used throughout the application.
/// These exceptions are thrown from the data layer (repositories, data sources) and
/// are caught by the domain/presentation layers to handle errors appropriately.
/// 
/// How to add new exceptions:
/// 1. Create a new class that implements Exception
/// 2. Add a final String message field for error details
/// 3. Add any additional fields specific to your exception (like statusCode for server errors)
/// 4. Create a const constructor that accepts the message and any additional parameters
/// 5. Override the toString() method to provide meaningful error descriptions
/// 
/// Example of adding a new exception:
/// ```dart
/// class DatabaseException implements Exception {
///   final String message;
///   final String? tableName;
/// 
///   const DatabaseException(this.message, [this.tableName]);
/// 
///   @override
///   String toString() => 'DatabaseException: $message (Table: $tableName)';
/// }
/// ```

/// Exception thrown when server-side errors occur
/// Used for HTTP 5xx errors, API failures, or backend issues
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, [this.statusCode]);

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

/// Exception thrown when network connectivity issues occur
/// Used for no internet connection, timeout errors, or DNS resolution failures
class NetworkException implements Exception {
  final String message;

  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when local cache/storage operations fail
/// Used for database errors, file system issues, or data persistence problems
class CacheException implements Exception {
  final String message;

  const CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

/// Exception thrown when input validation fails
/// Used for form validation errors, invalid data format, or business rule violations
class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when authentication fails
/// Used for invalid credentials, expired tokens, or login failures
class AuthenticationException implements Exception {
  final String message;

  const AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when authorization/permission errors occur
/// Used for insufficient permissions, forbidden access, or role-based restrictions
class AuthorizationException implements Exception {
  final String message;

  const AuthorizationException(this.message);

  @override
  String toString() => 'AuthorizationException: $message';
}

/// Exception thrown when an unexpected or unhandled error occurs
/// Used as a fallback for any errors that don't fit into other exception categories
class UnknownException implements Exception {
  final String message;

  const UnknownException(this.message);

  @override
  String toString() => 'UnknownException: $message';
}