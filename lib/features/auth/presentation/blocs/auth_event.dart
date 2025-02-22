import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart';

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

class NameChanged extends AuthEvent {
  final String name;
  NameChanged(this.name);
}

class EmailChanged extends AuthEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends AuthEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class PhoneChanged extends AuthEvent {
  final String phone;
  PhoneChanged(this.phone);
}
class ShowRegisterFormEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
   LogoutEvent(); // Using 'const' for optimization
}
