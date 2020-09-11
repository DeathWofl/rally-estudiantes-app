// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregunta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreguntaAdapter extends TypeAdapter<Pregunta> {
  @override
  final int typeId = 1;

  @override
  Pregunta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pregunta(
      preg: fields[0] as String,
      estacionID: fields[1] as int,
      apiID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pregunta obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.preg)
      ..writeByte(1)
      ..write(obj.estacionID)
      ..writeByte(2)
      ..write(obj.apiID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreguntaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
