import 'package:flutter/material.dart';
import 'widgets/bottom_navigation_bar.dart';

class CadastroPerfil extends StatefulWidget {
  const CadastroPerfil({super.key});

  @override
  State<CadastroPerfil> createState() => _CadastroPerfilState();
}

class _CadastroPerfilState extends State<CadastroPerfil> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _deficienciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Caminho Acessível'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cadastre seu Perfil',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.teal[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Seu nome',
                      hintText: 'Insira seu nome',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Insira seu email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Crie sua senha',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _deficienciaController,
                    decoration: const InputDecoration(
                      labelText: 'Pessoa com deficiência?',
                      hintText: 'Sim ou não',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Ação de cadastro
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Cadastrar-se'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
