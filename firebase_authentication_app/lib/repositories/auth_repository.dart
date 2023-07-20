import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_authentication_app/constants/db_constant.dart';
import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:firebase_authentication_app/models/user_model.dart';

class AuthRespository {
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;
  AuthRespository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fb_auth.User?> get user => firebaseAuth.authStateChanges();

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserModel(
        id: '',
        name: name,
        email: email,
        profileImage: 'https://picsum.photos/300',
        point: 0,
        rank: 'brozen',
      );
      await userRef.doc(userCredential.user?.uid).set(user.toJson());
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message ?? '',
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'undefine',
        message: e.toString(),
        plugin: 'undefine',
      );
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message ?? '',
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'undefine',
        message: e.toString(),
        plugin: 'undefine',
      );
    }
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
}
