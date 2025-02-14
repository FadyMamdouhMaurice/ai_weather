import 'package:ai_weather/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> login(String email, String password) async {

    print("AuthRepository: Attempting login with $email"); // Debugging

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Login successful!"); // Debugging

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print("Login failed, incorrect credentials."); // Debugging
      throw Exception('Login failed: $e');
    }
  }

  Future<UserModel?> register(UserModel user, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      user = UserModel(
        userId: userCredential.user!.uid,
        name: user.name,
        email: user.email,
        phone: user.phone,
      );
      await _firestore.collection('users').doc(user.userId).set(user.toJson());
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}