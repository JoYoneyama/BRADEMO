import 'package:flutter/material.dart';

class Ex5 extends StatelessWidget {
  const Ex5({super.key});

  Widget buttonSection(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.blue)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Flutter layout demo", textAlign: TextAlign.center,),
        )
      ),
      body: ListView(
        children: [

          // Imagem
          Image.network(
            "https://picsum.photos/600/300",
            width: double.infinity,
            height: 240,
            fit: BoxFit.cover,
          ),

          // Título
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Oeschinen Lake Campground",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Kandersteg, Switzerland",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.star, color: Colors.red),
                const Text("41"),
              ],
            ),
          ),

          // Botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonSection(Icons.call, "CALL"),
              buttonSection(Icons.near_me, "ROUTE"),
              buttonSection(Icons.share, "SHARE"),
            ],
          ),

          // Texto
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese "
              "Alps. Situated 1,578 meters above sea level, it is one of the "
              "larger Alpine Lakes. A gondola ride from Kandersteg, followed by "
              "a half-hour walk through pastures and pine forest, leads you to "
              "the lake, which warms to 20 degrees Celsius in the summer.",
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}