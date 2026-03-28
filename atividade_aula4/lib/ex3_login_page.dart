import 'package:atividade_aula4/ex3_home_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginPage({super.key});

  void login(BuildContext context) {
    String user = userController.text;
    String pass = passController.text;

    if (user == "admin" && pass == "1234") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login inválido")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://via.placeholder.com/150"),
            SizedBox(height: 20),

            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: "Usuário"),
            ),

            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Senha"),
            ),

            SizedBox(height: 20),

            FloatingActionButton(
              onPressed: () => login(context),
              child: Icon(Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}