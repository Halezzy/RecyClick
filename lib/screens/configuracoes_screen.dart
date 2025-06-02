
import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Modo Escuro'),
            value: false,
            onChanged: (bool value) {
              // Adicionar lógica de tema aqui
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Modo escuro em desenvolvimento')),
              );
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre o aplicativo'),
            subtitle: const Text('Versão 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Reciclick',
                applicationVersion: '1.0.0',
                children: const [
                  Text('Aplicativo para promover reciclagem e educação ambiental.'),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
