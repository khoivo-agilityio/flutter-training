import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

class UserModel {
  const UserModel({
    required this.uid,
    this.avatarUrl,
    this.name,
    this.email,
    this.farmName,
    this.country,
    this.state,
    this.city,
    this.village,
    this.farmCapacity,
    this.farmType,
    this.fcmToken,
  });

  final String uid;
  final String? avatarUrl;
  final String? name;
  final String? email;
  final String? farmName;
  final String? country;
  final String? state;
  final String? city;
  final String? village;
  final String? farmCapacity;
  final String? farmType;
  final String? fcmToken;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserModel(
    uid: '',
    avatarUrl: '',
    email: '',
    name: '',
    farmName: '',
    country: '',
    state: '',
    city: '',
    village: '',
    farmCapacity: '',
    farmType: '',
  );

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data["name"] ?? "",
      email: data["email"] ?? "",
      farmName: data["farmName"] ?? "",
      country: data["country"] ?? "",
      state: data["state"] ?? "",
      city: data["city"] ?? "",
      village: data["village"] ?? "",
      farmCapacity: data["farmCapacity"] ?? "",
      farmType: data["farmType"] ?? "",
      avatarUrl: data["avatarUrl"],
      fcmToken: data["fcmToken"] ?? "",
    );
  }

  UserModel copyWith({
    String? uid,
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
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      farmName: farmName ?? this.farmName,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      village: village ?? this.village,
      farmCapacity: farmCapacity ?? this.farmCapacity,
      farmType: farmType ?? this.farmType,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  factory UserModel.fromDB(UserDbModel map) {
    return UserModel(
      uid: map.uid,
      name: map.name,
      email: map.email,
      farmName: map.farmName,
      country: map.country,
      state: map.state,
      city: map.city,
      village: map.village,
      farmCapacity: map.farmCapacity,
      farmType: map.farmType,
      avatarUrl: map.avatarUrl,
      fcmToken: map.fcmToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (farmName != null) 'farmName': farmName,
      if (country != null) 'country': country,
      if (state != null) 'state': state,
      if (city != null) 'city': city,
      if (village != null) 'village': village,
      if (farmCapacity != null) 'farmCapacity': farmCapacity,
      if (farmType != null) 'farmType': farmType,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (fcmToken != null) 'fcmToken': fcmToken,
    };
  }
}
