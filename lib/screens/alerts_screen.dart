import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: Column(
        children: [
          // Cabeçalho Smart Garden
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            color: const Color(0xFF8BC34A),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.local_florist, color: Colors.white, size: 32),
                SizedBox(height: 8),
                Text(
                  'Smart Garden',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Seção de título e descrição
          Container(
            width: double.infinity,
            color: const Color(0xFFC8E6C9),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alertas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Veja os alertas recentes sobre suas plantas',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          // Lista de alertas
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                AlertCard(
                  icon: Icons.water_drop,
                  color: Colors.blue,
                  title: 'Planta com pouca umidade',
                  description:
                      'A umidade do solo da Samambaia está baixa. Regue em breve.',
                  date: 'Hoje 08:45',
                ),
                AlertCard(
                  icon: Icons.wb_sunny,
                  color: Colors.orange,
                  title: 'Excesso de sol',
                  description:
                      'A Hortênsia recebeu muita luz solar direta. Mova para um local mais sombreado.',
                  date: 'Ontem 15:20',
                ),
                AlertCard(
                  icon: Icons.thermostat,
                  color: Colors.red,
                  title: 'Temperatura crítica',
                  description:
                      'A temperatura da Orquídea subiu para um nível muito alto.',
                  date: '27 de abr. 12:33',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlertCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String date;

  const AlertCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD0F0C0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
