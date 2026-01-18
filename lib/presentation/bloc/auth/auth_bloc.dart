/// Authentication BLoC (Presentation Layer)
/// 
/// This BLoC manages authentication state throughout the application.
/// It handles user login, logout, and authentication status checking.
/// Follows the BLoC pattern for predictable state management.
/// 
/// Key responsibilities:
/// - Process authentication events from the UI
/// - Coordinate with domain layer (UserRepository) to execute business logic
/// - Emit appropriate states based on operation results
/// - Handle loading states and error cases
/// 
/// How to add new authentication features:
/// 1. Add new events to auth_event.dart (e.g., RegisterRequested)
/// 2. Add corresponding states to auth_state.dart (e.g., RegisterSuccess, RegisterFailure)
/// 3. Add event handler method in this BLoC following the pattern below
/// 4. Register the handler in the constructor using on<EventType>()
/// 
/// Example of adding a registration feature:
/// ```dart
/// // In constructor:
/// on<RegisterRequested>(_onRegisterRequested);
/// 
/// // Handler method:
/// Future<void> _onRegisterRequested(
///   RegisterRequested event,
///   Emitter<AuthState> emit,
/// ) async {
///   emit(const AuthLoading());
/// 
///   try {
///     final user = await userRepository.register(
///       event.name, 
///       event.email, 
///       event.password,
///     );
///     emit(RegisterSuccess(user: user));
///   } catch (e) {
///     emit(RegisterFailure(message: e.toString()));
///   }
/// }
/// ```
/// 
/// Usage in UI:
/// ```dart
/// context.read<AuthBloc>().add(LoginRequested(email: email, password: password));
/// ```

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await userRepository.login(event.email, event.password);
      emit(LoginSuccess(user: user));
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      await userRepository.logout();
      emit(const LogoutSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await userRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }
}