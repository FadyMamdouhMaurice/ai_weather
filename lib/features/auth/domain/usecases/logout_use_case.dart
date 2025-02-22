import 'package:ai_weather_cellula/features/auth/data/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  Future<void> execute() {
    return authRepository.logout();
  }
}