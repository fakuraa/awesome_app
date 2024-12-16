// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StorageAdapter extends TypeAdapter<Storage> {
  @override
  final int typeId = 0;

  @override
  Storage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Storage(
      key: fields[0] as String,
      value: fields[1] as dynamic,
      expiredDate: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Storage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.expiredDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
