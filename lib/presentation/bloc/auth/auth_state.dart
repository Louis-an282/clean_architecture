/// Authentication States (BLoC Pattern)
/// 
/// This file defines all possible authentication states that the UI can
/// be in. States represent the current condition of the authentication
/// system and determine what the UI should display.
/// 
/// State categories:
/// - Initial states (AuthInitial, AuthLoading)
/// - Authentication status states (AuthAuthenticated, AuthUnauthenticated)
/// - Operation result states (Success/Failure pairs for each operation)
/// - Error states with descriptive messages
/// 
/// Design principles:
/// - All states extend the abstract AuthState class
/// - States are immutable (all fields final)
/// - States extend Equatable for easy testing and comparison
/// - Success states include relevant data (user entity)
/// - Failure states include error messages for UI display
/// - States are specific to their operations for clear UI handling
/// 
/// How to add new authentication states:
/// 1. Create new state classes extending AuthState
/// 2. Add required fields for the state data
/// 3. Create const constructors
/// 4. Override props getter to include all fields
/// 5. Create both Success and Failure variants for operations
/// 6. Handle the new states in BlocBuilder widgets
/// 
/// Example of adding new states:
/// ```dart
/// class EmailVerificationSent extends AuthState {
///   final String email;
/// 
///   const EmailVerificationSent({required this.email});
/// 
///   @override
///   List<Object> get props => [email];
/// }
/// 
/// class EmailVerificationSuccess extends AuthState {
///   const EmailVerificationSuccess();
/// }
/// 
/// class EmailVerificationFailure extends AuthState {
///   final String message;
/// 
///   const EmailVerificationFailure({required this.message});
/// 
///   @override
///   List<Object> get props => [message];
/// }
/// 
/// class ProfileUpdateSuccess extends AuthState {
///   final UserEntity updatedUser;
/// 
///   const ProfileUpdateSuccess({required this.updatedUser});
/// 
///   @override
///   List<Object> get props => [updatedUser];
/// }
/// ```
/// 
/// Usage in UI widgets:
/// ```dart
/// BlocBuilder<AuthBloc, AuthState>(
///   builder: (context, state) {
///     if (state is AuthLoading) {
///       return LoadingWidget();
///     } else if (state is LoginSuccess) {
///       return HomeScreen();
///     } else if (state is LoginFailure) {
///       return LoginScreen(error: state.message);
///     } else if (state is AuthUnauthenticated) {
///       return LoginScreen();
///     }
///     return SplashScreen();
///   },
/// )
/// ```

import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginSuccess extends AuthState {
  final UserEntity user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailure extends AuthState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterSuccess extends AuthState {
  final UserEntity user;

  const RegisterSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterFailure extends AuthState {
  final String message;

  const RegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

class LogoutFailure extends AuthState {
  final String message;

  const LogoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ForgotPasswordSuccess extends AuthState {
  const ForgotPasswordSuccess();
}

class ForgotPasswordFailure extends AuthState {
  final String message;

  const ForgotPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess();
}

class ResetPasswordFailure extends AuthState {
  final String message;

  const ResetPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangePasswordSuccess extends AuthState {
  const ChangePasswordSuccess();
}

class ChangePasswordFailure extends AuthState {
  final String message;

  const ChangePasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}