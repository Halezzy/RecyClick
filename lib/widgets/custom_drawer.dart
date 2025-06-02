
import 'package:flutter/material.dart';
import '../screens/perfil_screen.dart';
import '../screens/configuracoes_screen.dart';
import '../screens/conquistas_screen.dart';
import '../screens/login_screen.dart';
import '../screens/ecopontos_screen.dart'; // nova tela

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Text('Menu Reciclick', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilScreen())),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events),
            title: const Text('Conquistas'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConquistasScreen())),
          ),
          ListTile(
            leading: Icon(Icons.eco),
            title: const Text('Ecopontos'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EcopontosScreen())),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConfiguracoesScreen())),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair'),
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
          ),
        ],
      ),
    );
  }
}
