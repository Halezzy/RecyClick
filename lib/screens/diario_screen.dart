import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/entrada_diario.dart';
import '../db/entrada_diario_db.dart';
import '../services/notificacao_service.dart';

/// Tela que gerencia o Diário de ações sustentáveis.
/// Permite visualizar, adicionar e concluir ações com agendamento de notificações.
class DiarioScreen extends StatefulWidget {
  const DiarioScreen({super.key});

  @override
  State<DiarioScreen> createState() => _DiarioScreenState();
}

class _DiarioScreenState extends State<DiarioScreen> {
  List<EntradaDiario> _entradas = [];

  final controller = TextEditingController();
  final tipoController = TextEditingController();
  final observacoesController = TextEditingController();
  DateTime? dataSelecionada;

  @override
  void initState() {
    super.initState();
    _carregar(); // Carrega entradas ao iniciar
  }

  /// Recarrega as entradas do Hive.
  void _carregar() {
    setState(() {
      _entradas = EntradaDiarioDB.getAll();
    });
  }

  /// Salva uma nova entrada e agenda uma notificação.
  Future<void> _salvar() async {
    if (controller.text.isEmpty || tipoController.text.isEmpty || dataSelecionada == null) return;

    final nova = EntradaDiario(
      titulo: controller.text,
      data: dataSelecionada!,
      tipoMaterial: tipoController.text,
      observacoes: observacoesController.text,
      concluido: false,
    );

    await EntradaDiarioDB.add(nova);
    controller.clear();
    tipoController.clear();
    observacoesController.clear();
    dataSelecionada = null;
    _carregar();

    // Agendar notificação 2h antes da ação
    await NotificacaoService.agendarNotificacao(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      titulo: 'Ação sustentável agendada',
      corpo: 'Lembre-se: ${nova.titulo} em ${DateFormat('dd/MM/yyyy').format(nova.data)}',
      dataHora: nova.data.subtract(const Duration(hours: 2)),
    );
  }

  /// Marca uma ação como concluída.
  Future<void> _concluir(int index) async {
    final atual = _entradas[index];
    final atualizado = atual.copyWith(concluido: true);
    await EntradaDiarioDB.update(index, atualizado);
    _carregar();
  }

  /// Libera os controladores.
  @override
  void dispose() {
    controller.dispose();
    tipoController.dispose();
    observacoesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Futuros e Concluídos
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Diário de Ações'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Futuros'),
              Tab(text: 'Concluídos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLista(false), // Futuras ações
            _buildLista(true),  // Ações concluídas
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _mostrarFormulario,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Lista filtrada de ações por status.
  Widget _buildLista(bool concluidos) {
    final filtrados = _entradas.where((e) => e.concluido == concluidos).toList();
    return ListView.builder(
      itemCount: filtrados.length,
      itemBuilder: (_, i) {
        final e = filtrados[i];
        return ListTile(
          title: Text(e.titulo),
          subtitle: Text(
            '${DateFormat('dd/MM/yyyy').format(e.data)} | ${e.tipoMaterial}\n${e.observacoes}',
          ),
          isThreeLine: true,
          trailing: !e.concluido
              ? IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () => _concluir(_entradas.indexOf(e)),
          )
              : null,
        );
      },
    );
  }

  /// Exibe formulário de nova entrada no diário.
  void _mostrarFormulario() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Wrap(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo de Material'),
            ),
            TextField(
              controller: observacoesController,
              decoration: const InputDecoration(labelText: 'Observações'),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: Text(
                dataSelecionada == null
                    ? 'Selecionar data'
                    : DateFormat('dd/MM/yyyy').format(dataSelecionada!),
              ),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    dataSelecionada = picked;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _salvar();
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
