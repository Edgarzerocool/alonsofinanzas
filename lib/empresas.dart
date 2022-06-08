import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class empresas extends StatelessWidget {
  const empresas({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Revisar el historial de los ultimos 10 dias de:"),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: null,
              child: const Text("Apple"),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: null,
              child: const Text("Amazon"),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: null,
              child: const Text("Microsoft"),
            ),
          ],
        ),
      ),
    );
  }
}