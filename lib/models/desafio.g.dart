// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desafio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DesafioAdapter extends TypeAdapter<Desafio> {
  @override
  final int typeId = 1;

  @override
  Desafio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Desafio(
      titulo: fields[0] as String,
      descricao: fields[1] as String,
      status: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Desafio obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesafioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
