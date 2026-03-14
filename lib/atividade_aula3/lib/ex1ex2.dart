import 'package:flutter/material.dart';

class Ex1Ex2 extends StatelessWidget {
  String title;

  Ex1Ex2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: Transform.translate(
          offset: const Offset(-30, 0),
          child: Container(
            padding: EdgeInsets.only(left: 8, top: 8, right: 16, bottom: 64),
            color: Colors.orange,
            child: const Text(
              "Hi Mom 🐣",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.phone, color: Colors.deepPurpleAccent),
                Text("call", style: TextStyle(color: Colors.deepPurpleAccent)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.airplanemode_active_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                Text("route", style: TextStyle(color: Colors.deepPurpleAccent)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.share, color: Colors.deepPurpleAccent),
                Text("share", style: TextStyle(color: Colors.deepPurpleAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}