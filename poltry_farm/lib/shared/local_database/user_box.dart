import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

abstract class UserBox {
  Future<void> saveUser(UserDbModel user);
  Future<UserDbModel?> getUser();
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? fcmToken,
  });
  Future<void> deleteUser();
  Future<void> clear();
}

class UserBoxImpl implements UserBox {
  final Box<UserDbModel> box;

  UserBoxImpl(this.box);

  static const _userKey = 'userBox';

  @override
  Future<void> saveUser(UserDbModel user) async {
    await box.put(_userKey, user);
  }

  @override
  Future<UserDbModel?> getUser() async {
    return box.get(_userKey);
  }

  @override
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? fcmToken,
  }) async {
    final userBox = Hive.box<UserDbModel>('userBox');

    if (userBox.isEmpty) return;

    final user = userBox.getAt(0);

    if (user == null) return;

    bool hasChanged = false;

    if (fullName != null && fullName != user.fullName) {
      user.fullName = fullName;
      hasChanged = true;
    }

    if (email != null && email != user.email) {
      user.email = email;
      hasChanged = true;
    }

    if (phoneNumber != null && phoneNumber != user.phoneNumber) {
      user.phoneNumber = phoneNumber;
      hasChanged = true;
    }

    if (avatarUrl != null && avatarUrl != user.avatarUrl) {
      user.avatarUrl = avatarUrl;
      hasChanged = true;
    }

    if (fcmToken != null && fcmToken != user.avatarUrl) {
      user.fcmToken = fcmToken;
      hasChanged = true;
    }

    if (hasChanged) {
      await user.save();
    }
  }

  @override
  Future<void> deleteUser() async {
    await box.delete(_userKey);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }
}
