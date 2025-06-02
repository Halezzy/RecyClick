import 'package:hive/hive.dart';
import '../models/entrada_diario.dart';

class EntradaDiarioDB {
  static late Box<EntradaDiario> _box;

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(EntradaDiarioAdapter());
    }
    _box = await Hive.openBox<EntradaDiario>('entradas');
  }

  static List<EntradaDiario> getAll() => _box.values.toList();

  static Future<void> add(EntradaDiario entrada) async {
    await _box.add(entrada);
  }

  static Future<void> update(int index, EntradaDiario entrada) async {
    await _box.putAt(index, entrada);
  }

  static Future<void> delete(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> clear() async {
    await _box.clear();
  }
}
