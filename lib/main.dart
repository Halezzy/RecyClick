import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recyclick/services/notificacao_service.dart';

import 'firebase_options.dart';

// Models e DBs
import 'models/ecoponto.dart';
import 'models/desafio.dart';
import 'models/entrada_diario.dart';
import 'db/ecoponto_db.dart';
import 'db/desafio_db.dart';
import 'db/entrada_diario_db.dart';

// Tela inicial
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 📦 Inicializa Hive
  await Hive.initFlutter();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);


  // ✅ Registra todos os HiveAdapters necessários
  Hive.registerAdapter(EcopontoAdapter());
  Hive.registerAdapter(DesafioAdapter());
  Hive.registerAdapter(EntradaDiarioAdapter());

  // 📂 Abre todas as boxes usadas
  await EcopontoDB.init();
  await DesafioDB.init();
  await EntradaDiarioDB.init();
  await NotificacaoService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recyclick',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
