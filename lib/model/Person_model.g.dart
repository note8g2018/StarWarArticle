// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 0;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      userName: fields[1] as String,
      email: fields[2] as String,
      id: fields[0] as String,
      passWord: fields[3] as String,
      isLogin: fields[4] as bool,
      regTimeUTC: fields[5] as DateTime,
      lastTimeLoginUTC: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.passWord)
      ..writeByte(4)
      ..write(obj.isLogin)
      ..writeByte(5)
      ..write(obj.regTimeUTC)
      ..writeByte(6)
      ..write(obj.lastTimeLoginUTC);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
