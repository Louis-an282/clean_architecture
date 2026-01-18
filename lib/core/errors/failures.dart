/// Failure Classes for Clean Architecture Error Handling
/// 
/// This file contains failure classes that represent error states in the domain layer.
/// Failures are the result of converting exceptions (from data layer) into domain-friendly
/// error objects that can be safely passed to the presentation layer.
/// 
/// Key differences between Failures and Exceptions:
/// - Exceptions: Thrown in data layer (repositories, datasources)
/// - Failures: Returned as part of Either<Failure, Success> from use cases
/// 
/// How to add new failures:
/// 1. Create a new class that extends the abstract Failure class
/// 2. Use const constructor with super.message to pass error message to parent
/// 3. The Equatable mixin automatically handles equality comparison based on props
/// 
/// Example of adding a new failure:
/// ```dart
/// class DatabaseFailure extends Failure {
///   const DatabaseFailure(super.message);
/// }
/// 
/// // Usage in repository:
/// return Left(DatabaseFailure('Failed to save data to local database'));
/// ```
/// 
/// Note: All failures extend Equatable for easy comparison and testing

import 'package:equatable/equatable.dart';

/// Abstract base class for all failure types
/// Extends Equatable to enable easy comparison between failure instances
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Represents server-side error failures (HTTP 5xx, API errors, backend issues)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Represents network connectivity failures (no internet, timeouts, DNS issues)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Represents local cache/storage operation failures (database errors, file system issues)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Represents input validation failures (form errors, invalid data, business rule violations)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Represents authentication failures (invalid credentials, expired tokens, login errors)
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

/// Represents authorization/permission failures (insufficient permissions, forbidden access)
class AuthorizationFailure extends Failure {
  const AuthorizationFailure(super.message);
}

/// Represents unexpected or unhandled failures (fallback for unknown errors)
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}