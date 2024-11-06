import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.jpg'), // Ruta de la imagen
                fit: BoxFit.cover, // Hace que la imagen cubra toda la pantalla
              ),
            ),
          ),
          // Contenido encima de la imagen (nombre de la app y mensaje)
          Positioned(
            top: 50, // Espacio desde la parte superior de la pantalla
            left: 20, // Espacio desde el borde izquierdo
            right: 20, // Espacio desde el borde derecho
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Alineación centrada
              children: [
                // Nombre de la aplicación
                Text(
                  'Cine Stream', // Nombre de la app
                  style: TextStyle(
                    fontSize: 42, // Tamaño de la fuente
                    color: Colors.white, // Color del texto (blanco)
                    fontWeight: FontWeight.bold, // Negrita
                    fontFamily: 'Courier New', // Fuente
                  ),
                ),
                SizedBox(height: 20), // Espacio entre el nombre y el mensaje
                // Mensaje de bienvenida
                Text(
                  '¡Bienvenido a Cine Stream! Nos emociona tenerte con nosotros, aquí encontrarás una gran variedad de películas, desde clásicos hasta lo más nuevo. Explora nuestro catálogo y déjate sorprender. ¡Es hora de disfrutar del cine! ¿Qué película quieres ver hoy?',
                  style: TextStyle(
                    fontSize: 19, // Tamaño de la fuente
                    color: Colors.white, // Color del texto (blanco)
                    fontWeight: FontWeight.normal, // Estilo normal
                  ),
                  textAlign: TextAlign.center, // Centrado del mensaje
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
