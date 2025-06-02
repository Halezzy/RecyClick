import 'package:hive/hive.dart';
import '../models/desafio.dart';

class DesafioDB {
  static late Box<Desafio> _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(DesafioAdapter());
    }
    _box = await Hive.openBox<Desafio>('desafios');
  }

  static List<Desafio> getAll() => _box.values.toList();

  static Future<void> add(Desafio desafio) async {
    await _box.add(desafio);
  }

  static Future<void> update(int index, Desafio desafio) async {
    await _box.putAt(index, desafio);
  }

  static Future<void> delete(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> clear() async {
    await _box.clear();
  }
}
