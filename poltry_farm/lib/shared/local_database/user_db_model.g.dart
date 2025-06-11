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
      name: fields[1] as String?,
      email: fields[2] as String?,
      farmName: fields[3] as String?,
      country: fields[4] as String?,
      state: fields[5] as String?,
      city: fields[6] as String?,
      village: fields[7] as String?,
      farmCapacity: fields[8] as String?,
      farmType: fields[9] as String?,
      avatarUrl: fields[10] as String?,
      fcmToken: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDbModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.farmName)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.village)
      ..writeByte(8)
      ..write(obj.farmCapacity)
      ..writeByte(9)
      ..write(obj.farmType)
      ..writeByte(10)
      ..write(obj.avatarUrl)
      ..writeByte(11)
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
