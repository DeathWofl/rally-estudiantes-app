// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regRespuestas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegRespuestasAdapter extends TypeAdapter<RegRespuestas> {
  @override
  final int typeId = 3;

  @override
  RegRespuestas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegRespuestas(
      preguntaID: fields[0] as int,
      calificacion: fields[1] as int,
      equipoID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RegRespuestas obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.preguntaID)
      ..writeByte(1)
      ..write(obj.calificacion)
      ..writeByte(2)
      ..write(obj.equipoID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegRespuestasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
