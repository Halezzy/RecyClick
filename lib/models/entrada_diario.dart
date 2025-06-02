import 'package:hive/hive.dart';

part 'entrada_diario.g.dart';

@HiveType(typeId: 2)
class EntradaDiario {
  @HiveField(0)
  final String titulo;

  @HiveField(1)
  final DateTime data;

  @HiveField(2)
  final String tipoMaterial;

  @HiveField(3)
  final String observacoes;

  @HiveField(4)
  final bool concluido;

  EntradaDiario({
    required this.titulo,
    required this.data,
    required this.tipoMaterial,
    required this.observacoes,
    required this.concluido,
  });

  EntradaDiario copyWith({bool? concluido}) {
    return EntradaDiario(
      titulo: titulo,
      data: data,
      tipoMaterial: tipoMaterial,
      observacoes: observacoes,
      concluido: concluido ?? this.concluido,
    );
  }
}
