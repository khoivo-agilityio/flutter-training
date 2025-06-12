import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:poltry_farm/repositories/base_repository.dart';
import 'package:poltry_farm/shared/local_database/local_database.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';
import 'package:poltry_farm/shared/user_model.dart';

class AuthRepository extends BaseRepository {
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('User not found');
      }

      final userData = await getUserData(firebaseUser.uid);
      return userData;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    } catch (_) {
      throw Exception('Failed to sign in');
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("user").doc(uid).get();

      if (!doc.exists) {
        throw Exception("User data not found");
      }

      final user = UserModel.fromFirestore(doc);

      await HiveLocalDb.instance.userBox.saveUser(
        UserDbModel.fromUserModel(user),
      );

      return user;
    } catch (e) {
      throw Exception("Failed to get user data");
    }
  }

  Future<void> updateUserData({required UserModel user, File? avatar}) async {
    try {
      String? avatarUrl;
      if (avatar != null) {
        try {
          final ref = firebaseStorage.ref().child('avartar/${user.uid}.jpg');
          final task = await ref.putFile(avatar);
          final url = await task.ref.getDownloadURL();
          avatarUrl = url;
        } on FirebaseException catch (e) {
          log("Failed to upload avatar: ${e.code} - ${e.message}");

          throw Exception("Failed to upload avatar");
        }
      }

      final newUserData = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        farmName: user.farmName,
        country: user.country,
        state: user.state,
        city: user.city,
        village: user.village,
        farmCapacity: user.farmCapacity,
        farmType: user.farmType,
        avatarUrl: avatarUrl,
      );

      await firestore
          .collection("user")
          .doc(user.uid)
          .update(newUserData.toMap());

      await HiveLocalDb.instance.userBox.updateUser(
        name: newUserData.name,
        email: user.email,
        farmName: user.farmName,
        country: user.country,
        state: user.state,
        city: user.city,
        village: user.village,
        farmCapacity: user.farmCapacity,
        farmType: user.farmType,
        avatarUrl: avatarUrl,
      );
    } catch (e) {
      throw Exception("Failed to save user data");
    }
  }
}
