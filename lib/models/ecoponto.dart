import 'package:hive/hive.dart';

part 'ecoponto.g.dart';

@HiveType(typeId: 0)
class Ecoponto {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String nome;

  Ecoponto({
    required this.latitude,
    required this.longitude,
    required this.nome,
  });
}
