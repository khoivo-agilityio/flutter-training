import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/shared/user_model.dart';

part 'user_db_model.g.dart';

@HiveType(typeId: 0)
class UserDbModel extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? farmName;

  @HiveField(4)
  String? country;

  @HiveField(5)
  String? state;

  @HiveField(6)
  String? city;

  @HiveField(7)
  String? village;

  @HiveField(8)
  String? farmCapacity;

  @HiveField(9)
  String? farmType;

  @HiveField(10)
  String? avatarUrl;

  @HiveField(11)
  String? fcmToken;

  UserDbModel({
    required this.uid,
    this.name,
    this.email,
    this.farmName,
    this.country,
    this.state,
    this.city,
    this.village,
    this.farmCapacity,
    this.farmType,
    this.avatarUrl,
    this.fcmToken,
  });

  factory UserDbModel.fromUserModel(PfUserModel userModel) {
    return UserDbModel(
      uid: userModel.uid,
      name: userModel.name,
      email: userModel.email,
      farmName: userModel.farmName,
      country: userModel.country,
      state: userModel.state,
      city: userModel.city,
      village: userModel.village,
      farmCapacity: userModel.farmCapacity,
      farmType: userModel.farmType,
      avatarUrl: userModel.avatarUrl,
      fcmToken: userModel.fcmToken,
    );
  }
}
