import 'package:hive/hive.dart';

part 'desafio.g.dart';

@HiveType(typeId: 1)
class Desafio extends HiveObject {
  @HiveField(0)
  final String titulo;

  @HiveField(1)
  final String descricao;

  @HiveField(2)
  final String status; // 'disponivel', 'aceito', 'concluido'

  Desafio({
    required this.titulo,
    required this.descricao,
    required this.status,
  });

  Desafio copyWith({
    String? titulo,
    String? descricao,
    String? status,
  }) {
    return Desafio(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      status: status ?? this.status,
    );
  }
}
