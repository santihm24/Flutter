import 'package:flutter/material.dart';
import 'package:diccionario/config/tema/app_tema.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppTema appTema = AppTema(); // Crea una instancia de AppTema

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diccionario',
      theme: appTema.theme(), // Aplica el tema aquí
      home: TraductorScreen(),
    );
  }
}

class TraductorScreen extends StatefulWidget {
  @override
  _TraductorScreenState createState() => _TraductorScreenState();
}

class _TraductorScreenState extends State<TraductorScreen> {
  final Map<String, String> diccionario = {
    'red': 'rojo',
    'salad': 'ensalada',
    'cat': 'gato',
    'car': 'carro',
  };

  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _buscarController = TextEditingController();

  String? _resultado;

  void _agregarPalabra() {
    final String clave = _claveController.text.trim();
    final String valor = _valorController.text.trim();

    if (clave.isNotEmpty && valor.isNotEmpty) {
      setState(() {
        diccionario[clave] = valor;
        _claveController.clear();
        _valorController.clear();
      });
    }
  }

  void _traducirPalabra() {
    final String palabra = _buscarController.text.trim();
    setState(() {
      _resultado = diccionario[palabra] != null
          ? 'La traducción de "$palabra" es "${diccionario[palabra]}"'
          : 'No se encontró la traducción.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diccionario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _claveController,
              decoration: InputDecoration(labelText: 'Palabra en inglés'),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: 'Palabra en español'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  Theme.of(context).colorScheme.inversePrimary, 
              ),
              onPressed: _agregarPalabra,
              child: Text(
                'Agregar Palabra',
                style: TextStyle(
                  color: Colors.black, 
                  fontFamily: 'Arial', 
                  fontSize: 16, 
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _buscarController,
              decoration: InputDecoration(labelText: 'Palabra a traducir'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              onPressed: _traducirPalabra,
              child: Text(
                'Traducir',
                  style: TextStyle(
                  color: Colors.black, 
                  fontFamily: 'Arial', 
                  fontSize: 16, 
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_resultado != null)
              Text(
                _resultado!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            Text(
              'Palabras en el diccionario:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: diccionario.length,
                itemBuilder: (context, index) {
                  String clave = diccionario.keys.elementAt(index);
                  String valor = diccionario[clave]!;
                  return ListTile(
                    title: Text('$clave - $valor'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
