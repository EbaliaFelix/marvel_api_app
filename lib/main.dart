import 'package:flutter/material.dart';
import 'home_screen.dart'; // Asegúrate de importar el archivo home_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineStream', // Título de la app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Establece HomeScreen como la pantalla principal
    );
  }
}