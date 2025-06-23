import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class PlantsScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPlantSelected;

  const PlantsScreen({Key? key, required this.onPlantSelected}) : super(key: key);

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseReference _plantsRef = FirebaseDatabase.instance.ref('plants');

  List<Map<String, dynamic>> _plants = [];
  List<Map<String, dynamic>> _filteredPlants = [];

  @override
  void initState() {
    super.initState();

    _plantsRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        List<Map<String, dynamic>> loadedPlants = [];

        data.forEach((key, value) {
          final plant = Map<String, dynamic>.from(value);
          plant['key'] = key;
          loadedPlants.add(plant);
        });

        setState(() {
          _plants = loadedPlants;
          _filteredPlants = loadedPlants;
        });
      } else {
        setState(() {
          _plants = [];
          _filteredPlants = [];
        });
      }
    });
  }

  void _filterPlants(String query) {
    final filtered = _plants.where((plant) {
      final plantName = (plant['nome'] ?? '').toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return plantName.contains(searchQuery);
    }).toList();
    setState(() {
      _filteredPlants = filtered;
    });
  }

  void abrirFormularioCadastro({Map<String, dynamic>? plantaParaEditar}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NovaPlantaForm(
        plantaExistente: plantaParaEditar,
        onSalvar: (novaPlanta) async {
          if (plantaParaEditar != null) {
            await _plantsRef.child(plantaParaEditar['key']).update(novaPlanta);
          } else {
            await _plantsRef.push().set(novaPlanta);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void removerPlanta(Map<String, dynamic> planta) async {
    if (planta.containsKey('key')) {
      await _plantsRef.child(planta['key']).remove();
    }
  }

  Widget buildPlantaCard(Map<String, dynamic> plant) {
    final imagePath = plant['image']?.toString() ?? '';
    final isNetworkImage = imagePath.startsWith('http');
    final isFileImage = !isNetworkImage && imagePath.isNotEmpty && File(imagePath).existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: isNetworkImage
                  ? NetworkImage(imagePath)
                  : isFileImage
                      ? FileImage(File(imagePath))
                      : const AssetImage('assets/images/default.jpg') as ImageProvider,
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant['nome'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.water_drop,
                          color: plant['statusColor'] != null ? Color(plant['statusColor']) : Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Text(plant['status'] ?? ''),
                    ],
                  ),
                  Text(plant['tempo'] ?? '', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onPlantSelected(plant);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Monitorar planta"),
                ),
                TextButton(
                  onPressed: () {
                    abrirFormularioCadastro(plantaParaEditar: plant);
                  },
                  child: Row(
                    children: const [Icon(Icons.edit, size: 16), SizedBox(width: 4), Text("Editar")],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    removerPlanta(plant);
                  },
                  child: const Text(
                    "Remover",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFA0C85E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
                  child: Row(
                    children: [
                      Image.asset('assets/logo2.png', height: 32, width: 32),
                      const SizedBox(width: 8),
                      const Text(
                        'Smart Garden',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD2E8C9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Minhas Plantas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => abrirFormularioCadastro(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Cadastrar Plantas',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: _filterPlants,
                    decoration: const InputDecoration(
                      labelText: 'Buscar Planta',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: _filteredPlants.map((plant) => buildPlantaCard(plant)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NovaPlantaForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSalvar;
  final Map<String, dynamic>? plantaExistente;

  const NovaPlantaForm({Key? key, required this.onSalvar, this.plantaExistente}) : super(key: key);

  @override
  State<NovaPlantaForm> createState() => _NovaPlantaFormState();
}

class _NovaPlantaFormState extends State<NovaPlantaForm> {
  final TextEditingController _nomeController = TextEditingController();
  File? _image;
  bool _isNomeValido = false;

  @override
  void initState() {
    super.initState();

    if (widget.plantaExistente != null) {
      _nomeController.text = widget.plantaExistente!['nome'] ?? '';
      if (widget.plantaExistente!['image'] != null && !widget.plantaExistente!['image'].toString().startsWith('assets/')) {
        _image = File(widget.plantaExistente!['image']);
      }
      _isNomeValido = _nomeController.text.trim().isNotEmpty;
    }

    _nomeController.addListener(() {
      final isNotEmpty = _nomeController.text.trim().isNotEmpty;
      if (isNotEmpty != _isNomeValido) {
        setState(() {
          _isNomeValido = isNotEmpty;
        });
      }
    });
  }

  Future<void> selecionarImagem() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.plantaExistente != null ? "Editar Planta" : "Nova Planta",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome da planta",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: selecionarImagem,
                icon: const Icon(Icons.image),
                label: const Text("Selecionar imagem"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Image.file(_image!, height: 120),
                ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isNomeValido
                    ? () {
                        final novaPlanta = {
                          'nome': _nomeController.text.trim(),
                          'image': _image?.path ?? 'assets/images/default.jpg',
                          'status': 'Nova planta',
                          'tempo': 'Atualizado agora',
                          'statusColor': Colors.green.value,
                        };
                        widget.onSalvar(novaPlanta);
                      }
                    : null,
                child: const Text("Salvar planta"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDB94F),
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
