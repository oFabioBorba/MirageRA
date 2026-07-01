import 'dart:async';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TelaAR(),
    );
  }
}

class TelaAR extends StatefulWidget {
  const TelaAR({super.key});

  @override
  State<TelaAR> createState() => _TelaARState();
}

class _TelaARState extends State<TelaAR> {
  bool _modeloCarregando = true;
  Timer? _loadingTimer;

  String _chaveModeloSelecionado = '1';

  final Map<String, Map<String, String>> _modelos = {
    '1': {'glb': 'assets/models/modelAR.glb', 'nome': 'Modelo 1'},
    '2': {'glb': 'assets/models/modelo2.glb', 'nome': 'Modelo 2'},
  };

  @override
  void initState() {
    super.initState();
    _iniciarTimerLoading();
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  void _iniciarTimerLoading() {
    _loadingTimer?.cancel();
    _loadingTimer = Timer(const Duration(seconds: 6), () {
      if (mounted && _modeloCarregando) {
        setState(() => _modeloCarregando = false);
      }
    });
  }

  void _trocarModelo(String chave) {
    if (chave == _chaveModeloSelecionado) return;
    setState(() {
      _chaveModeloSelecionado = chave;
      _modeloCarregando = true;
    });
    _iniciarTimerLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildModeloAR(),

          if (_modeloCarregando) _buildOverlayLoading(),

          _buildControles(),
        ],
      ),
    );
  }

  Widget _buildModeloAR() {
    final modelo = _modelos[_chaveModeloSelecionado]!;

    return Positioned.fill(
      child: ModelViewer(
        key: ValueKey(_chaveModeloSelecionado),
        src: modelo['glb']!,
        alt: modelo['nome']!,

        ar: true,
        arModes: const ['scene-viewer', 'webxr', 'quick-look'],

        backgroundColor: const Color.fromARGB(255, 0, 0, 0),

        cameraControls: true,
        autoRotate: true,
        autoRotateDelay: 1000,
        cameraOrbit: '0deg 75deg 3m',
        minCameraOrbit: 'auto auto 1m',
        maxCameraOrbit: 'auto auto 8m',
        fieldOfView: '30deg',
        minFieldOfView: '15deg',
        maxFieldOfView: '60deg',
        interactionPrompt: InteractionPrompt.auto,
        environmentImage: 'neutral',
        shadowIntensity: 1,
        shadowSoftness: 1,
      ),
    );
  }

  Widget _buildOverlayLoading() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withAlpha(200),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.cyanAccent),
              SizedBox(height: 16),
              Text(
                'Carregando modelo 3D...',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControles() {
    return Column(
      children: [
        SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(160),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.view_in_ar, color: Colors.cyanAccent, size: 22),
                SizedBox(width: 8),
                Text(
                  'MIRAGE RA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                Spacer(),
                Text(
                  'Toque no ícone AR ↙',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        SafeArea(
          top: false,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(160),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecionar modelo',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _modelos.entries.map((e) {
                    final selecionado = e.key == _chaveModeloSelecionado;
                    return GestureDetector(
                      onTap: () => _trocarModelo(e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: selecionado
                              ? Colors.cyanAccent
                              : Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selecionado
                                ? Colors.cyanAccent
                                : Colors.white24,
                          ),
                        ),
                        child: Text(
                          e.value['nome']!,
                          style: TextStyle(
                            color: selecionado ? Colors.black : Colors.white,
                            fontWeight: selecionado
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
