import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recyclick/services/location_service.dart';
import 'package:recyclick/models/ecoponto.dart';
import 'package:recyclick/db/ecoponto_db.dart';
import 'package:geocoding/geocoding.dart';
import 'ecopontos_screen.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});
  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _currentPosition = const LatLng(-23.5505, -46.6333);
  final TextEditingController _searchController = TextEditingController();
  bool _carregado = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final pos = await LocationService.getCurrentPosition();
    if (pos != null) {
      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
        _carregado = true;
      });
    }
  }

  Future<void> _irParaEndereco(String endereco) async {
    try {
      final List<Location> locations = await locationFromAddress(endereco);
      if (locations.isNotEmpty) {
        final destino = LatLng(locations.first.latitude, locations.first.longitude);
        final controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(destino));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Endereço não encontrado')),
      );
    }
  }

  Future<void> _salvarEcoponto() async {
    final controller = await _controller.future;
    LatLng center = await controller.getLatLng(
      const ScreenCoordinate(x: 200, y: 400),
    );

    final nome = await showDialog<String>(
      context: context,
      builder: (ctx) {
        final input = TextEditingController();
        return AlertDialog(
          title: const Text('Nome do Ecoponto'),
          content: TextField(
            controller: input,
            decoration: const InputDecoration(hintText: 'Ex: Praça Central'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
            ElevatedButton(onPressed: () => Navigator.pop(ctx, input.text), child: const Text('Salvar')),
          ],
        );
      },
    );

    if (nome != null && nome.isNotEmpty) {
      final novo = Ecoponto(latitude: center.latitude, longitude: center.longitude, nome: nome);
      await EcopontoDB.addEcoponto(novo);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ecoponto salvo!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'Ver Ecopontos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcopontosScreen()),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          if (_carregado)
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 16),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) => _controller.complete(controller),
            )
          else
            const Center(child: CircularProgressIndicator()),

          const Center(
            child: Icon(Icons.location_pin, size: 40, color: Colors.red),
          ),

          Positioned(
            top: 10,
            left: 10,
            right: 60,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Pesquisar cidade, rua ou CEP',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_searchController.text.isNotEmpty) {
                        _irParaEndereco(_searchController.text);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _salvarEcoponto,
        label: const Text('Salvar ponto'),
        icon: const Icon(Icons.add_location_alt),
      ),
    );
  }
}
