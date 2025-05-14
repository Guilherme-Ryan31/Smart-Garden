// lib/screens/overview_screen.dart
 import 'package:flutter/material.dart';
 class AlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alertas')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.water_drop, color: Colors.blue),
            title: Text('Planta com pouca umidade'),
            subtitle: Text('Hoje 08:45'),
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny, color: Colors.orange),
            title: Text('Excesso de sol'),
            subtitle: Text('Ontem 15:20'),
          ),
        ],
      ),
    );
  }
 }
