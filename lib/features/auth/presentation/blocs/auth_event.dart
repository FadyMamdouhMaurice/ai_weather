import 'package:ai_weather/features/auth/data/models/user_model.dart';

abstract class AuthEvent {}
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}
class RegisterEvent extends AuthEvent {
  final UserModel user;
  final String password;
  RegisterEvent(this.user, this.password);
}
class LogoutEvent extends AuthEvent {}
