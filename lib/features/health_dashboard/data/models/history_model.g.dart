// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepsHistoryAdapter extends TypeAdapter<StepsHistory> {
  @override
  final int typeId = 1;

  @override
  StepsHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepsHistory(
      date: fields[0] as DateTime,
      steps: fields[1] as int,
      updatedAt: fields[2] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, StepsHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.steps)
      ..writeByte(2)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
