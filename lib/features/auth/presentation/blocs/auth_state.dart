import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart';
import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart' show UserEntity;

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

class RegisterFormState extends AuthState {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final bool isFormValid;

  RegisterFormState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.phone = '',
  }) : isFormValid = name.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword == password &&
      phone.isNotEmpty;

  RegisterFormState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? phone,
  }) {
    return RegisterFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phone: phone ?? this.phone,
    );
  }
}