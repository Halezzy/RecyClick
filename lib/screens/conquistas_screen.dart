
import 'package:flutter/material.dart';

class ConquistasScreen extends StatelessWidget {
  const ConquistasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Conquistas'),
        backgroundColor: Colors.green[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.emoji_events, color: Colors.amber),
            title: Text('Primeira Reciclagem'),
            subtitle: Text('Parabéns por começar sua jornada sustentável!'),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events, color: Colors.amber),
            title: Text('10 Itens Reciclados'),
            subtitle: Text('Você já reciclou 10 itens diferentes.'),
          ),
          ListTile(
            leading: Icon(Icons.emoji_events, color: Colors.amber),
            title: Text('Mapa desbloqueado'),
            subtitle: Text('Você marcou seu primeiro ecoponto no mapa.'),
          ),
        ],
      ),
    );
  }
}
