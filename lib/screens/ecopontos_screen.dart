import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclick/db/ecoponto_db.dart';
import 'package:recyclick/models/ecoponto.dart';
import 'package:share_plus/share_plus.dart';

class EcopontosScreen extends StatefulWidget {
  const EcopontosScreen({super.key});
  @override
  State<EcopontosScreen> createState() => _EcopontosScreenState();
}

class _EcopontosScreenState extends State<EcopontosScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  List<Ecoponto> _ecopontos = [];
  final Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();
    _carregarEcopontos();
  }

  void _carregarEcopontos() {
    final ecopontos = EcopontoDB.getAll();
    setState(() {
      _ecopontos = ecopontos;
      _marcadores.clear();
      for (var e in ecopontos) {
        _marcadores.add(
          Marker(
            markerId: MarkerId('${e.latitude}_${e.longitude}'),
            position: LatLng(e.latitude, e.longitude),
            infoWindow: InfoWindow(title: e.nome),
          ),
        );
      }
    });
  }

  void _editarNome(Ecoponto eco, int index) async {
    final controller = TextEditingController(text: eco.nome);
    final novoNome = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar nome'),
        content: TextField(controller: controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Salvar')),
        ],
      ),
    );
    if (novoNome != null) {
      final atualizado = Ecoponto(
        latitude: eco.latitude,
        longitude: eco.longitude,
        nome: novoNome,
      );
      EcopontoDB.atualizar(index, atualizado);
      _carregarEcopontos();
    }
  }

  void _compartilhar(Ecoponto eco) {
    Share.share(
      'Ecoponto: ${eco.nome}\nLocalização: ${eco.latitude}, ${eco.longitude}',
    );
  }

  void _excluir(int index) {
    EcopontoDB.remover(index);
    _carregarEcopontos();
  }

  Future<void> _focarNoMapa(Ecoponto eco) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(eco.latitude, eco.longitude),
        17,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng centro = _ecopontos.isNotEmpty
        ? LatLng(_ecopontos.first.latitude, _ecopontos.first.longitude)
        : const LatLng(-23.5505, -46.6333);

    return Scaffold(
      appBar: AppBar(title: const Text('Ecopontos Salvos')),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: centro,
                zoom: 14,
              ),
              markers: _marcadores,
              onMapCreated: (controller) => _controller.complete(controller),
            ),
          ),
          Expanded(
            child: _ecopontos.isEmpty
                ? const Center(child: Text('Nenhum ecoponto salvo.'))
                : ListView.builder(
              itemCount: _ecopontos.length,
              itemBuilder: (_, i) {
                final e = _ecopontos[i];
                return ListTile(
                  title: Text(e.nome),
                  subtitle: Text('Lat: ${e.latitude}, Lng: ${e.longitude}'),
                  onTap: () => _focarNoMapa(e),
                  trailing: PopupMenuButton<String>(
                    onSelected: (val) {
                      if (val == 'editar') _editarNome(e, i);
                      if (val == 'compartilhar') _compartilhar(e);
                      if (val == 'excluir') _excluir(i);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'editar', child: Text('Editar')),
                      PopupMenuItem(value: 'compartilhar', child: Text('Compartilhar')),
                      PopupMenuItem(value: 'excluir', child: Text('Excluir')),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
