// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskmodelAdapter extends TypeAdapter<Taskmodel> {
  @override
  final int typeId = 0;

  @override
  Taskmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Taskmodel(
      title: fields[0] as String,
      subTitle: fields[1] as String,
    )
      ..done = fields[2] as bool
      ..createdAt = fields[3] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Taskmodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subTitle)
      ..writeByte(2)
      ..write(obj.done)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
