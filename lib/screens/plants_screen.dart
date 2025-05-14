import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  Widget buildPlantaCard({
    required String nome,
    required String status,
    required String tempo,
    required String imageAsset,
    required Color statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageAsset),
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.water_drop, color: statusColor, size: 16),
                      const SizedBox(width: 4),
                      Text(status),
                    ],
                  ),
                  Text(
                    tempo,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Ver detalhes"),
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
      appBar: AppBar(
        title: const Text("Minhas Plantas"),
        backgroundColor: const Color(0xFFB4D99A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildPlantaCard(
              nome: "Samambaia",
              status: "Saudável",
              tempo: "Atualizado há 2h",
              imageAsset: "assets/images/samambaia.jpg",
              statusColor: Colors.green,
            ),
            buildPlantaCard(
              nome: "Orquídea",
              status: "Precisa de água",
              tempo: "Atualizado há 4h",
              imageAsset: "assets/images/orquidea.jpg",
              statusColor: Colors.blue,
            ),
            buildPlantaCard(
              nome: "Cacto",
              status: "Precisa de luz",
              tempo: "Atualizado há 1h",
              imageAsset: "assets/images/cacto.jpg",
              statusColor: Colors.orange,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFB4D99A),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Tela atual: Plantas
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Visão geral"),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: "Plantas"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alertas"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        ],
      ),
    );
  }
}
