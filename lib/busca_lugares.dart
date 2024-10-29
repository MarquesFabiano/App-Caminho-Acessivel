import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/bottom_navigation_bar.dart';
import 'database_helper.dart';

class BuscaLugares extends StatefulWidget {
  const BuscaLugares({super.key});

  @override
  State<BuscaLugares> createState() => _BuscaLugaresState();
}

class _BuscaLugaresState extends State<BuscaLugares> {
  final TextEditingController _lugarController = TextEditingController();
  List<dynamic> _resultados = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> buscarLugares() async {
    final lugar = _lugarController.text;
    if (lugar.isEmpty) return;

    final response = await http.get(Uri.parse('https://us-central1-projetomapa-438017.cloudfunctions.net/buscarLugaresAcessiveis?lugar=${Uri.encodeComponent(lugar)}'));
    if (response.statusCode == 200) {
      setState(() {
        _resultados = json.decode(response.body);
      });
    }
  }

  Future<void> favoritarLugar(Map<String, dynamic> lugar) async {
    await _databaseHelper.insertFavorito(lugar);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lugar adicionado aos favoritos!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Buscar Lugares Acessíveis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _lugarController,
              decoration: const InputDecoration(
                labelText: 'Digite o nome ou tipo de lugar',
                hintText: 'Ex: restaurantes, parques, etc.',
              ),
            ),
            ElevatedButton(
              onPressed: buscarLugares,
              child: const Text('Buscar'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resultados.length,
                itemBuilder: (context, index) {
                  final lugar = _resultados[index];
                  return ListTile(
                    title: Text(lugar['nome']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Endereço: ${lugar['endereco']}'),
                        Text('Acessibilidade: ${lugar['acessibilidade']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        favoritarLugar(lugar);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
