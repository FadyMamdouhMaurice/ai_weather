import 'package:ai_weather/features/auth/data/repositories/auth_repository.dart';
import 'package:ai_weather/features/auth/domain/entities/user.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<UserEntity?> execute(String email, String password) async {
    print("LoginUseCase: Executing login with email: $email");

    final userModel = await authRepository.login(email, password);

    if (userModel != null) {
      final userEntity = UserEntity(email: userModel.email, userId: userModel.userId, name: userModel.name, phone: userModel.phone); // Convert UserModel to UserEntity
      print("LoginUseCase: Converted UserModel to UserEntity: $userEntity");
      return userEntity;
    }

    return null;
  }

}
