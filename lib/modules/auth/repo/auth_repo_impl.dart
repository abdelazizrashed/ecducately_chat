import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educately_chat/config/app_logger.dart';
import 'package:educately_chat/modules/auth/models/user_model.dart';
import 'package:educately_chat/modules/auth/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel?> login({
    required String email,
    required String password,
    required Function(String msg) onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final db = FirebaseFirestore.instance;
      final doc = await db.collection("users").doc(credential.user!.uid).get();
      if (!doc.exists) {
        onError("User doesn't exist");
        AppLogger.error(
          tag: "Auth",
          value: "Couldn't find doc",
        );
      }

      return UserModel.fromJson(doc.data()!);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        onError('invalid-credential');
      }
    } catch (e, t) {
      onError(e.toString());
      AppLogger.error(tag: "Auth", value: e);
      AppLogger.error(tag: "Auth", value: t);
    }
    return null;
  }

  @override
  Future<UserModel?> signup({
    required String email,
    required String password,
    required String name,
    required Function(String msg) onError,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final db = FirebaseFirestore.instance;
      await db.collection("users").doc(credential.user!.uid).set({
        "uid": credential.user!.uid,
        "name": name,
        "email": email,
        "photo":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwdIVSqaMsmZyDbr9mDPk06Nss404fosHjLg&s",
      });

      return UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        photo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwdIVSqaMsmZyDbr9mDPk06Nss404fosHjLg&s",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('weak-password');
      } else if (e.code == 'email-already-in-use') {
        onError('email-already-in-use');
      }
    } catch (e, t) {
      onError(e.toString());
      AppLogger.error(
        tag: "Auth",
        value: e,
      );
      AppLogger.error(
        tag: "Auth",
        value: t,
      );
    }
    return null;
  }
}
