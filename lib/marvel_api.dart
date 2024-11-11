import 'dart:convert';
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

    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&ts=$timestamp&hash=$hash'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['data']['results'];

      // Extraemos los nombres de los personajes
      return results.map((character) => character['name'] as String).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
