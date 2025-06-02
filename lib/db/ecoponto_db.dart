import 'package:hive/hive.dart';
import '../models/ecoponto.dart';

class EcopontoDB {
  static late Box<Ecoponto> _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EcopontoAdapter());
    }
    _box = await Hive.openBox<Ecoponto>('ecopontos');
  }

  static Future<void> addEcoponto(Ecoponto ecoponto) async {
    await _box.add(ecoponto);
  }

  static List<Ecoponto> getAll() {
    return _box.values.toList();
  }

  static Future<void> atualizar(int index, Ecoponto ecoponto) async {
    await _box.putAt(index, ecoponto);
  }

  static Future<void> remover(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> limparTodos() async {
    await _box.clear();
  }
}
