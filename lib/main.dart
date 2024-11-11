import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class MarvelApi {
  final String apiKey =
      'ff63f55b2dc2fc1dea0cca690c8a5d9e'; // Reemplaza con tu API Key
  final String privateKey =
      '32de57ac7f578e00b90716632a4980249566c615'; // Reemplaza con tu Private Key
  final String baseUrl =
      'https://gateway.marvel.com/v1/public/characters'; // Endpoint para personajes

  // Método para generar el hash MD5
  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  // Método para obtener los personajes
  Future<List<String>> fetchCharacters() async {
    final timestamp =
        DateTime.now().millisecondsSinceEpoch ~/ 1000; // Timestamp en segundos
    final hash =
        _generateMd5('$timestamp$privateKey$apiKey'); // Generación del hash MD5

    // Generar la URL con los parámetros necesarios
    final url = Uri.parse('$baseUrl?apikey=$apiKey&ts=$timestamp&hash=$hash');

    try {
      // Realizar la solicitud HTTP GET a la API de Marvel
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Si la respuesta es exitosa, procesar los datos
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['data']['results'];

        // Extraer los nombres de los personajes
        return results.map((character) => character['name'] as String).toList();
      } else {
        // Si la respuesta no es exitosa, lanzar una excepción
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores
      print('Error al cargar personajes: $e');
      throw Exception('Failed to load characters');
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> characters = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  // Método para cargar los personajes
  Future<void> _loadCharacters() async {
    setState(() {
      isLoading = true;
    });

    try {
      MarvelApi api = MarvelApi();
      characters = await api
          .fetchCharacters(); // Llamada a la API para obtener los personajes
    } catch (e) {
      print('Error al cargar los personajes: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Marvel Characters')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed:
                    _loadCharacters, // Al hacer clic en el botón, recargar los personajes
                child: Text('Cargar personajes'),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator()) // Indicador de carga
                  : Expanded(
                      child: ListView.builder(
                        itemCount: characters.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(characters[index]),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
