// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipoAdapter extends TypeAdapter<Equipo> {
  @override
  final int typeId = 0;

  @override
  Equipo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equipo(
      matriculaE1: fields[0] as String,
      matriculaE2: fields[1] as String,
      matriculaE3: fields[2] as String,
      codigoGrupo: fields[3] as String,
      contraGrupo: fields[4] as String,
      apiID: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Equipo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.matriculaE1)
      ..writeByte(1)
      ..write(obj.matriculaE2)
      ..writeByte(2)
      ..write(obj.matriculaE3)
      ..writeByte(3)
      ..write(obj.codigoGrupo)
      ..writeByte(4)
      ..write(obj.contraGrupo)
      ..writeByte(5)
      ..write(obj.apiID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
