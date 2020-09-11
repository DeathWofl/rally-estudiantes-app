// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuestas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RespuestasAdapter extends TypeAdapter<Respuestas> {
  @override
  final int typeId = 2;

  @override
  Respuestas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Respuestas(
      resp: fields[0] as String,
      valor: fields[1] as int,
      preguntaID: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Respuestas obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.resp)
      ..writeByte(1)
      ..write(obj.valor)
      ..writeByte(2)
      ..write(obj.preguntaID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespuestasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
