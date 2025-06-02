import 'package:flutter/material.dart';
import 'package:recyclick/db/desafio_db.dart';
import 'package:recyclick/models/desafio.dart';

class DesafiosScreen extends StatefulWidget {
  const DesafiosScreen({super.key});

  @override
  State<DesafiosScreen> createState() => _DesafiosScreenState();
}

class _DesafiosScreenState extends State<DesafiosScreen> {
  List<Desafio> _todos = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() {
    setState(() {
      _todos = DesafioDB.getAll();
    });
  }

  void _atualizarStatus(int index, String novoStatus) async {
    final atualizado = _todos[index].copyWith(status: novoStatus);
    await DesafioDB.update(index, atualizado);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Missões Sustentáveis'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Disponíveis'),
              Tab(text: 'Aceitos'),
              Tab(text: 'Concluídos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLista('disponivel', 'Aceitar', (i) => _atualizarStatus(i, 'aceito')),
            _buildLista('aceito', 'Concluir', (i) => _atualizarStatus(i, 'concluido')),
            _buildLista('concluido', null, null),
          ],
        ),
      ),
    );
  }

  Widget _buildLista(String status, String? botaoLabel, void Function(int)? onPressed) {
    final desafiosFiltrados = _todos
        .asMap()
        .entries
        .where((entry) => entry.value.status == status)
        .toList();

    if (desafiosFiltrados.isEmpty) {
      return const Center(child: Text('Nenhum desafio.'));
    }

    return ListView.builder(
      itemCount: desafiosFiltrados.length,
      itemBuilder: (context, index) {
        final i = desafiosFiltrados[index].key!;
        final desafio = desafiosFiltrados[index].value;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(desafio.titulo),
            subtitle: Text(desafio.descricao),
            trailing: botaoLabel != null
                ? ElevatedButton(
              onPressed: () => onPressed!(i),
              child: Text(botaoLabel),
            )
                : null,
          ),
        );
      },
    );
  }
}
