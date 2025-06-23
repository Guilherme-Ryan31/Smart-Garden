import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';       // Import para inicializar Firebase
import 'package:firebase_database/firebase_database.dart'; // Realtime Database
import 'overview_screen.dart';
import 'plant_screen.dart';
import 'alerts_screen.dart';
import 'settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Inicializa Firebase
  runApp(SmartGardenApp());
}

class SmartGardenApp extends StatelessWidget {
  const SmartGardenApp({super.key});

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo2.png',
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Cuide das suas plantas de forma simples e intuitiva',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFFFDB94F),
                        foregroundColor: Color(0xFF352E35),
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => Dashboard()),
                        );
                      },
                      child: Text('Começar agora'),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;

  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref('selectedPlant');

  Map<String, dynamic> selectedPlant = {
    'nome': 'Samambaia',
    'image': 'assets/samambaia.png',
    'tempo': '10h',
    'status': 'Saudável',
    'statusColor': Colors.green,
  };

  void updateSelectedPlant(Map<String, dynamic> newPlant) {
    setState(() {
      selectedPlant = newPlant;
      _index = 0; // volta para a tela Overview quando seleciona planta
    });

    // Atualiza planta selecionada no Firebase Realtime Database
    _dbRef.set({
      'nome': newPlant['nome'],
      'image': newPlant['image'],
      'tempo': newPlant['tempo'],
      'status': newPlant['status'],
    }).catchError((error) {
      print('Erro ao atualizar planta no Firebase: $error');
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
      backgroundColor: Colors.white,
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
