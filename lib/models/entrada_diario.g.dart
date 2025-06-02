// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrada_diario.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntradaDiarioAdapter extends TypeAdapter<EntradaDiario> {
  @override
  final int typeId = 2;

  @override
  EntradaDiario read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntradaDiario(
      titulo: fields[0] as String,
      data: fields[1] as DateTime,
      tipoMaterial: fields[2] as String,
      observacoes: fields[3] as String,
      concluido: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EntradaDiario obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.tipoMaterial)
      ..writeByte(3)
      ..write(obj.observacoes)
      ..writeByte(4)
      ..write(obj.concluido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntradaDiarioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
