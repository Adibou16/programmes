// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseCardAdapter extends TypeAdapter<ExerciseCard> {
  @override
  final int typeId = 1;

  @override
  ExerciseCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseCard(
      imagePath: fields[0] as String,
      tableData: (fields[1] as List)
          .map((dynamic e) => (e as List).cast<int>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseCard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.tableData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
