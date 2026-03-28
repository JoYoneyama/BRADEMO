import 'package:atividade_aula4/ex3_login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.yellow,
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("Exercício 2")),
        body: Center(
          child: Text("Fundo amarelo (sobrescrito)"),
        ),
      ),
    );
  }
}