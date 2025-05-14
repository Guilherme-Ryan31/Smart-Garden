// Smart Garden - Flutter App Prototype UI

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
      backgroundColor: Color(0xFFD2E8C9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Image.asset('assets/images/img.png'), // ilustracao
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Dashboard()),
                  ),
                  child: Text('Começar agora'),
                )
              ],
            ),
          )
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

  final _screens = [OverviewScreen(),PlantsScreen(), AlertsScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Visão geral'),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'Plantas'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alertas'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
