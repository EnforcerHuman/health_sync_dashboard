// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps_history_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepsHistoryModelAdapter extends TypeAdapter<StepsHistoryModel> {
  @override
  final int typeId = 0;

  @override
  StepsHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepsHistoryModel(
      dayKey: fields[0] as String,
      steps: fields[1] as int,
      lastSyncedAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StepsHistoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dayKey)
      ..writeByte(1)
      ..write(obj.steps)
      ..writeByte(2)
      ..write(obj.lastSyncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
