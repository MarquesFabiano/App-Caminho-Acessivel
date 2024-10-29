import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'widgets/bottom_navigation_bar.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({super.key});

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> _favoritos = [];

  @override
  void initState() {
    super.initState();
    carregarFavoritos();
  }

  Future<void> carregarFavoritos() async {
    final favoritos = await _databaseHelper.getFavoritos();
    setState(() {
      _favoritos = favoritos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Favoritos'),
      ),
      body: _favoritos.isEmpty
          ? const Center(child: Text('A lista de favoritos está vazia.'))
          : ListView.builder(
        itemCount: _favoritos.length,
        itemBuilder: (context, index) {
          final lugar = _favoritos[index];
          return ListTile(
            title: Text(lugar['nome']),
            subtitle: Text('Endereço: ${lugar['endereco']}'),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
