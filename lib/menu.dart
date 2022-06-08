import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'empresas.dart';

class menu extends StatelessWidget {
  const menu({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demostracion finanzas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Menú"),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const empresas()),);
              },
              child: const Text("Revisar histórico"),
            ),
            FlatButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Salir"),
            ),
          ],
        ),
      ),
    );
  }
}