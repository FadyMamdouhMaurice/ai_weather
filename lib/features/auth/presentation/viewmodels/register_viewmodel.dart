import 'package:flutter/material.dart';
import 'package:ai_weather/features/auth/data/models/user_model.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_event.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthBloc authBloc;

  RegisterViewModel(this.authBloc);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? get name => nameController.text.isEmpty ? null : nameController.text;
  String? get email => emailController.text.isEmpty ? null : emailController.text;
  String? get password => passwordController.text.isEmpty ? null : passwordController.text;
  String? get confirmPassword => confirmPasswordController.text.isEmpty ? null : confirmPasswordController.text;
  String? get phone => phoneController.text.isEmpty ? null : phoneController.text;

  bool get isFormValid {
    print("Checking form validity: name=$name, email=$email, phone=$phone, password=$password, confirm=$confirmPassword");
    return name != null && email != null && phone != null && password != null && confirmPassword == password;
  }
  void register() {
    if (isFormValid) {
      print("Register button clicked, form is valid.");

      final user = UserModel(
        userId: '',
        name: name!,
        email: email!,
        phone: phone!,
      );
      print("Dispatching RegisterEvent...");

      authBloc.add(RegisterEvent(user, password!));
      print("RegisterEvent added to AuthBloc.");

    }
    else {
      print("Form is invalid. Check required fields.");
    }
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }
}
