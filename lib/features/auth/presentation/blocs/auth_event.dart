import 'package:ai_weather/features/auth/domain/entities/user.dart';

abstract class AuthEvent {}
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}
class RegisterEvent extends AuthEvent {
  final UserEntity user;
  final String password;
  RegisterEvent(this.user, this.password);
}
class LogoutEvent extends AuthEvent {
   LogoutEvent(); // Using 'const' for optimization
}
