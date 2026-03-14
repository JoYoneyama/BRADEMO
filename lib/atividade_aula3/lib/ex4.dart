import 'package:flutter/material.dart';

class Ex4 extends StatelessWidget {
  const Ex4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Image Example"),
      ),
      body: Center(
        child: Column(
          children: [

            // Imagem menor
            FittedBox(
              fit: BoxFit.contain,
              child: Image.network(
                "https://picsum.photos/400/200",
                width: 300,
              ),
            ),

            // Espaço entre as imagens
            const SizedBox(height: 40),

            // Imagem maior
            FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                "https://picsum.photos/600/400",
                width: 350,
              ),
            ),

          ],
        ),
      ),
    );
  }
}