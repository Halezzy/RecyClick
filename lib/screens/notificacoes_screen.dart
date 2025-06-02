import 'package:flutter/material.dart';

class NotificacoesScreen extends StatelessWidget {
  const NotificacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificações"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            icon: Icons.recycling,
            title: 'Lembrete: Recicle hoje!',
            subtitle: 'Não se esqueça de separar seus resíduos corretamente.',
            time: 'Hoje, 08:00',
          ),
          NotificationCard(
            icon: Icons.emoji_events,
            title: 'Parabéns!',
            subtitle: 'Você completou o desafio semanal de reciclagem.',
            time: 'Ontem, 17:30',
          ),
          NotificationCard(
            icon: Icons.location_on,
            title: 'Novo ponto de coleta disponível',
            subtitle: 'Um ecoponto próximo foi adicionado ao mapa.',
            time: '2 dias atrás',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const NotificationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Icon(icon, color: Colors.green[800]),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
