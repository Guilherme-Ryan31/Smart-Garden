import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlantsScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onPlantSelected;

  const PlantsScreen({Key? key, required this.onPlantSelected}) : super(key: key);

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _plants = [
    {
      'nome': 'Samambaia',
      'status': 'Saudável',
      'tempo': 'Atualizado há 2h',
      'image': 'assets/images/samambaia.jpg',
      'statusColor': Colors.green,
    },
    {
      'nome': 'Orquídea',
      'status': 'Precisa de água',
      'tempo': 'Atualizado há 4h',
      'image': 'assets/images/orquidea.jpg',
      'statusColor': Colors.blue,
    },
    {
      'nome': 'Cacto',
      'status': 'Precisa de luz',
      'tempo': 'Atualizado há 1h',
      'image': 'assets/images/cacto.jpg',
      'statusColor': Colors.orange,
    },
  ];

  List<Map<String, dynamic>> _filteredPlants = [];

  @override
  void initState() {
    super.initState();
    _filteredPlants = _plants;
  }

  void _filterPlants(String query) {
    final filtered = _plants.where((plant) {
      final plantName = plant['nome'].toLowerCase();
      final searchQuery = query.toLowerCase();
      return plantName.contains(searchQuery);
    }).toList();
    setState(() {
      _filteredPlants = filtered;
    });
  }

  void abrirFormularioCadastro() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NovaPlantaForm(
      onSalvar: (novaPlanta) {
    setState(() {
      _plants.add(novaPlanta);
      _filteredPlants = _plants;
    });
  },
),

    );
  }

  Widget buildPlantaCard(Map<String, dynamic> plant) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(plant['image']),
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant['nome'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: plant['statusColor'], size: 16),
                      const SizedBox(width: 4),
                      Text(plant['status']),
                    ],
                  ),
                  Text(plant['tempo'], style: const TextStyle(color: Colors.grey)),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Monitorar planta"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 4),
                      Text("Editar"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          height: 140,
          decoration: const BoxDecoration(
            color: Color(0xFFA0C85E),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/logo.png', height: 32, width: 32),
                      const SizedBox(width: 8),
                      const Text('Smart Garden',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Minhas Plantas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: abrirFormularioCadastro,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Cadastrar planta',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
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
    );
  }
}

class NovaPlantaForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSalvar;

  const NovaPlantaForm({Key? key, required this.onSalvar}) : super(key: key);

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
    _nomeController.addListener(() {
      final isNotEmpty = _nomeController.text.trim().isNotEmpty;
      if (isNotEmpty != _isNomeValido){
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
          boxShadow: [
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
            // 🔻 Botão de fechar no topo
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
            const Text(
              "Nova Planta",
              style: TextStyle(
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
                  'nome': _nomeController.text,
                  'image':_image?.path?? 'assets/images/defaut.jpg',
                  'status': 'Nova planta', 
                  'tempo': 'Atualizado agora',
                  'statusColor': Colors.green,
                };
                widget.onSalvar(novaPlanta);
                Navigator.pop(context);
              }
              : null,
              child: const Text("Salvar planta"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFDB94F),
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
