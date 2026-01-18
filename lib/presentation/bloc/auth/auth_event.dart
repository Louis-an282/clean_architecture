/// Authentication Events (BLoC Pattern)
/// 
/// This file defines all possible authentication events that can be triggered
/// from the UI layer. Events represent user intentions or system triggers
/// that should cause the authentication state to change.
/// 
/// Key principles:
/// - All events extend the abstract AuthEvent class
/// - Events are immutable (all fields final)
/// - Events extend Equatable for easy testing and comparison
/// - Each event contains only the data needed to perform the action
/// 
/// How to add new authentication events:
/// 1. Create a new class extending AuthEvent
/// 2. Add required fields for the operation
/// 3. Create a const constructor
/// 4. Override props getter to include all fields
/// 5. Add the event handler in auth_bloc.dart
/// 
/// Example of adding a new event:
/// ```dart
/// class VerifyEmailRequested extends AuthEvent {
///   final String verificationCode;
/// 
///   const VerifyEmailRequested({required this.verificationCode});
/// 
///   @override
///   List<Object> get props => [verificationCode];
/// }
/// ```
/// 
/// Usage pattern:
/// ```dart
/// // Trigger from UI:
/// context.read<AuthBloc>().add(LoginRequested(
///   email: emailController.text,
///   password: passwordController.text,
/// ));
/// ```

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String? phone;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  });

  @override
  List<Object?> get props => [name, email, password, phone];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String email;
  final String password;

  const ResetPasswordRequested({
    required this.token,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [token, email, password];
}

class ChangePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword];
}