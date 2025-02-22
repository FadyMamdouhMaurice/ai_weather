import 'package:ai_weather_cellula/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required String userId,
    required String name,
    required String email,
    required String phone,
  }) : super(userId: userId, name: name, email: email, phone: phone);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
