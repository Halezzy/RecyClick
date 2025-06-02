
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'dart:io';

class ReconhecimentoScreen extends StatefulWidget {
  const ReconhecimentoScreen({super.key});

  @override
  State<ReconhecimentoScreen> createState() => _ReconhecimentoScreenState();
}

class _ReconhecimentoScreenState extends State<ReconhecimentoScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  String _resultado = "Nenhuma imagem processada";

  @override
  void initState() {
    super.initState();
    _inicializarCamera();
  }

  Future<void> _inicializarCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() {});
  }

  Future<void> _tirarFotoEReconhecer() async {
    final image = await _cameraController.takePicture();
    final inputImage = InputImage.fromFilePath(image.path);
    final labeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.6));
    final labels = await labeler.processImage(inputImage);

    if (labels.isEmpty) {
      setState(() => _resultado = "Nenhum material reconhecido.");
    } else {
      setState(() {
        _resultado = labels.map((e) => "${e.label} (${(e.confidence * 100).toStringAsFixed(1)}%)").join("\n");
      });
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reconhecimento de Materiais")),
      body: Column(
        children: [
          if (_cameraController.value.isInitialized)
            AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _tirarFotoEReconhecer,
            child: const Text("Tirar foto e reconhecer"),
          ),
          const SizedBox(height: 10),
          Text(_resultado, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
