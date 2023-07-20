import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_authentication_app/constants/db_constant.dart';
import 'package:firebase_authentication_app/models/custom_error.dart';
import 'package:firebase_authentication_app/models/user_model.dart';

class ProfileRepository {
  Future<UserModel> fetchProfile({required String uid}) async {
    try {
      final userDoc = await userRef.doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromDoc(userDoc);
      }
      throw 'user not found';
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
}
