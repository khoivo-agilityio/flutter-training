// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDbModelAdapter extends TypeAdapter<UserDbModel> {
  @override
  final typeId = 0;

  @override
  UserDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDbModel(
      uid: fields[0] as String,
      fullName: fields[1] as String,
      email: fields[2] as String,
      phoneNumber: fields[3] as String,
      avatarUrl: fields[4] as String?,
      fcmToken: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDbModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
