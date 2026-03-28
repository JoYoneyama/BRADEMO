import 'package:flutter/material.dart';

class Ex3 extends StatelessWidget {
  const Ex3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Stack & Positioned Widget"),
      ),
      body: Center(
        child: Stack(
          children: [

            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Green", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

            Positioned(
              left: 40,
              top: 40,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Red", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

            Positioned(
              left: 80,
              top: 80,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.purple,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Purple", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}