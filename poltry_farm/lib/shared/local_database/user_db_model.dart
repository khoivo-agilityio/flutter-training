import 'package:hive_ce/hive.dart';
import 'package:poltry_farm/shared/user_model.dart';

part 'user_db_model.g.dart';

@HiveType(typeId: 0)
class UserDbModel extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String fullName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String? avatarUrl;

  @HiveField(5)
  String? fcmToken;

  UserDbModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.avatarUrl,
    this.fcmToken,
  });

  factory UserDbModel.fromUserModel(UserModel userModel) {
    return UserDbModel(
      uid: userModel.uid,
      fullName: userModel.fullName,
      email: userModel.email,
      phoneNumber: userModel.phoneNumber,
      avatarUrl: userModel.avatarUrl,
    );
  }
}
