import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // já certo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Garden',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: WelcomeScreen(), // <--- aqui é onde começa sua navegação!
    );
  }
}
