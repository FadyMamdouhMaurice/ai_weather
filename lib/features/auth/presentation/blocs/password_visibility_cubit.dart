import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void toggleVisibility() => emit(!state);
}

class ConfirmPasswordVisibilityCubit extends Cubit<bool> {
  ConfirmPasswordVisibilityCubit() : super(true);

  void toggleVisibility() => emit(!state);
}
