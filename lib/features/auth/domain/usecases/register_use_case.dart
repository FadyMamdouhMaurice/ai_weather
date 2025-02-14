import 'package:ai_weather/features/auth/data/models/user_model.dart';
import 'package:ai_weather/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather/features/auth/domain/entities/user.dart';

class RegisterUseCase {
  final AuthRepository authRepository;
  RegisterUseCase(this.authRepository);

  Future<UserEntity?> execute(UserEntity user, String password) async{
    final userModel = UserModel(
      userId: user.userId,
      name: user.name,
      email: user.email,
      phone: user.phone,
    );
    return authRepository.register(userModel, password);
  }
}