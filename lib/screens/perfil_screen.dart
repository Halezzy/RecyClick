
import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Usuário Exemplo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'usuario@exemplo.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/configuracoes');
              },
              icon: const Icon(Icons.settings),
              label: const Text('Configurações'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
