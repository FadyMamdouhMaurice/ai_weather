import 'package:ai_weather_cellula/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/login_use_case.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/logout_use_case.dart';
import 'package:ai_weather_cellula/features/auth/domain/usecases/register_use_case.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_event.dart';
import 'package:ai_weather_cellula/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc(this.authRepository, this.registerUseCase, this.loginUseCase,
      this.logoutUseCase)
      : super(RegisterFormState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        UserEntity? user =
            await loginUseCase.execute(event.email, event.password);

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError("User not found"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<NameChanged>((event, emit) {
      if (state is RegisterFormState) {
        final currentState = state as RegisterFormState;
        emit(currentState.copyWith(name: event.name));
      }
    });

    on<EmailChanged>((event, emit) {
      if (state is RegisterFormState) {
        final currentState = state as RegisterFormState;
        emit(currentState.copyWith(email: event.email));
      }
    });

    on<PasswordChanged>((event, emit) {
      if (state is RegisterFormState) {
        final currentState = state as RegisterFormState;
        emit(currentState.copyWith(password: event.password));
      }
    });

    on<ConfirmPasswordChanged>((event, emit) {
      if (state is RegisterFormState) {
        final currentState = state as RegisterFormState;
        emit(currentState.copyWith(confirmPassword: event.confirmPassword));
      }
    });

    on<PhoneChanged>((event, emit) {
      if (state is RegisterFormState) {
        final currentState = state as RegisterFormState;
        emit(currentState.copyWith(phone: event.phone));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        UserEntity? user = await registerUseCase.execute(
          event.user,
          event.password,
        );

        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError("Registration failed. Please try again."));
        }
      } catch (e) {
        emit(AuthError("An error occurred: ${e.toString()}"));
      }
    });

    on<ShowRegisterFormEvent>((event, emit) {
      emit(RegisterFormState());
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase.execute();
      emit(AuthInitial());
    });
  }
}
