import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

abstract class UserBox {
  Future<void> saveUser(UserDbModel user);
  Future<UserDbModel?> getUser();
  Future<void> updateUser({
    String? name,
    String? email,
    String? farmName,
    String? country,
    String? state,
    String? city,
    String? village,
    String? farmCapacity,
    String? farmType,
    String? avatarUrl,
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
    String? name,
    String? email,
    String? farmName,
    String? country,
    String? state,
    String? city,
    String? village,
    String? farmCapacity,
    String? farmType,
    String? avatarUrl,
    String? fcmToken,
  }) async {
    final userBox = Hive.box<UserDbModel>('userBox');

    if (userBox.isEmpty) return;

    final user = userBox.getAt(0);

    if (user == null) return;

    bool hasChanged = false;

    if (name != null && name != user.name) {
      user.name = name;
      hasChanged = true;
    }

    if (email != null && email != user.email) {
      user.email = email;
      hasChanged = true;
    }

    if (farmName != null && farmName != user.farmName) {
      user.farmName = farmName;
      hasChanged = true;
    }
    if (country != null && country != user.country) {
      user.country = country;
      hasChanged = true;
    }
    if (state != null && state != user.state) {
      user.state = state;
      hasChanged = true;
    }
    if (city != null && city != user.city) {
      user.city = city;
      hasChanged = true;
    }
    if (village != null && village != user.village) {
      user.village = village;
      hasChanged = true;
    }
    if (farmCapacity != null && farmCapacity != user.farmCapacity) {
      user.farmCapacity = farmCapacity;
      hasChanged = true;
    }
    if (farmType != null && farmType != user.farmType) {
      user.farmType = farmType;
      hasChanged = true;
    }
    if (avatarUrl != null && avatarUrl != user.avatarUrl) {
      user.avatarUrl = avatarUrl;
      hasChanged = true;
    }
    if (fcmToken != null && fcmToken != user.fcmToken) {
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
