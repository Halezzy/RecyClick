import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';
import 'tabs/feed_tab.dart';
import 'tabs/network_tab.dart';
import 'tabs/mycash_tab.dart';
import 'tabs/inspirar_tab.dart';
import 'desafios_screen.dart';
import 'mapa_screen.dart';
import 'diario_screen.dart';
import 'reconhecimento_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  Widget _getScreenByIndex(int index) {
    switch (index) {
      case 1:
        return const DesafiosScreen();
      case 2:
        return const MapaScreen();
      case 3:
        return const DiarioScreen();
      case 4:
        return const ReconhecimentoScreen();
      default:
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white70,
              title: const Text('Novidades e Sustentabilidade'),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.dynamic_feed), text: 'Feed'),
                  Tab(icon: Icon(Icons.public), text: 'NetWork'),
                  Tab(icon: Icon(Icons.attach_money), text: 'MyCash'),
                  Tab(icon: Icon(Icons.lightbulb), text: 'Inspire'),
                ],
              ),
            ),
            drawer: const CustomDrawer(),
            body: const TabBarView(
              children: [
                FeedTab(),
                NetworkTab(),
                MyCashTab(),
                InspirarTab(),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreenByIndex(_index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        onTap: (int selectedIndex) {
          setState(() {
            _index = selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Desafios'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Diário'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'IA'),
        ],
      ),
    );
  }
}
