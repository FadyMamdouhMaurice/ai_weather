import 'package:ai_weather/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather/features/auth/domain/entities/user.dart';
import 'package:ai_weather/features/auth/domain/usecases/login_use_case.dart';
import 'package:ai_weather/features/auth/domain/usecases/logout_use_case.dart';
import 'package:ai_weather/features/auth/domain/usecases/register_use_case.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_event.dart';
import 'package:ai_weather/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;


  AuthBloc(this.authRepository, this.registerUseCase, this.loginUseCase, this.logoutUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        UserEntity? user = await loginUseCase.execute(event.email, event.password);

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
        UserEntity? user = await registerUseCase.execute(event.user, event.password);
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
      await logoutUseCase.execute();
      emit(AuthInitial());
    });
  }
}
