import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  final Map<String, dynamic> plant;

  const OverviewScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    // Sugestão com base no status da planta
    String status = plant['status'] ?? 'Indefinido';
    String sugestao = switch (status) {
      'Precisa de água' => 'Regue a planta.',
      'Precisa de luz' => 'Coloque a planta em um local mais iluminado.',
      _ => 'Sua planta está saudável!',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bloco superior com canto inferior esquerdo arredondado
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFA0C85E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/logo.png', height: 32, width: 32),
                        const SizedBox(width: 8),
                        const Text(
                          'Smart Garden',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Visão Geral',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card interno da planta monitorada
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0F0C0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              plant['image'] ?? '',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported, size: 70),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  plant['nome'] ?? 'Planta',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text('Planta monitorada'),
                                Text(
                                  plant['tempo'] ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: plant['statusColor'] ?? Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                'Detalhes da Planta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              detailTile(
                Icons.thermostat,
                "Temperatura",
                "22°C",
                iconColor: Colors.indigo,
              ),
              detailTile(
                Icons.water_drop,
                "Umidade do Solo",
                "Baixa",
                iconColor: Colors.blue,
              ),
              detailTile(
                Icons.wb_sunny,
                "Nível de Luz",
                "Adequado",
                iconColor: Colors.orange,
              ),

              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFA5D6A7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.volume_up, color: Colors.black),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        sugestao,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget detailTile(
    IconData icon,
    String title,
    String value, {
    Color iconColor = Colors.black,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
