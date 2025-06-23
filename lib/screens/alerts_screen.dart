import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFA0C85E),
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Image.asset('assets/logo2.png', height: 32, width: 32),
                const SizedBox(width: 8),
                const Text(
                  'Smart Garden',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFD2E8C9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32), 
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alertas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Veja os alertas recentes sobre suas plantas',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
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
        color: const Color(0xFFE5F5E5), // fundo esverdeado claro
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
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
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(description),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
