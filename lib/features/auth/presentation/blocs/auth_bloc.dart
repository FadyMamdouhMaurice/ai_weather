import 'package:ai_weather/features/auth/data/models/user_model.dart';
import 'package:ai_weather/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_event.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        UserModel? user = await authRepository.login(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError("User not found"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        UserModel? user = await authRepository.register(event.user, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError("Registration failed"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial());
    });
  }
}