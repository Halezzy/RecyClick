// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecoponto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EcopontoAdapter extends TypeAdapter<Ecoponto> {
  @override
  final int typeId = 0;

  @override
  Ecoponto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ecoponto(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      nome: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ecoponto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.nome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EcopontoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
