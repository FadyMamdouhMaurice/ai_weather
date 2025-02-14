import 'package:ai_weather/features/auth/domain/entities/user.dart';

abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated(this.user);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}