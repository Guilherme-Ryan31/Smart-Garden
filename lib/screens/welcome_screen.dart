import 'package:flutter/material.dart';
import 'overview_screen.dart';
import 'plant_screen.dart';
import 'alerts_screen.dart';
import 'settings_screen.dart';

void main() => runApp(SmartGardenApp());

class SmartGardenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Garden',
      theme: ThemeData(primarySwatch: Colors.green),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA0C85E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Image.asset(
              'assets/img.png',
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Imagem não encontrada'));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Seu jardim, na palma da mão',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Cuide das suas plantas de forma simples e intuitiva',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFFDB94F),
                    foregroundColor: Color(0xFF352E35),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Dashboard()),
                  ),
                  child: Text('Começar agora'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;

  // Agora é um mapa com dados da planta
  Map<String, dynamic> selectedPlant = {
    'nome': 'Samambaia',
    'image': 'assets/samambaia.png',
    'tempo': '10h',
    'status': 'Saudável',
    'statusColor': Colors.green,
  };

  // Atualiza a planta selecionada e retorna para a tela de visão geral
  void updateSelectedPlant(Map<String, dynamic> newPlant) {
    setState(() {
      selectedPlant = newPlant;
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      OverviewScreen(plant: selectedPlant),
      PlantsScreen(onPlantSelected: updateSelectedPlant),
      AlertsScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFD2E8C9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Visão geral', 0),
            _buildNavItem(Icons.local_florist, 'Plantas', 1),
            _buildNavItem(Icons.notifications, 'Alertas', 2),
            _buildNavItem(Icons.settings, 'Ajustes', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _index == index;
    return GestureDetector(
      onTap: () => setState(() => _index = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.black : Colors.black54,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
