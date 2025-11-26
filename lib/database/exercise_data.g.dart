// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseDataAdapter extends TypeAdapter<ExerciseData> {
  @override
  final int typeId = 1;

  @override
  ExerciseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseData(
      exerciseName: fields[0] as String,
      imagePath: fields[1] as String,
      tableData: (fields[2] as List)
          .map((dynamic e) => (e as List).cast<int>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.tableData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
