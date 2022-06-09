import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modelos/historico.dart';

class historicoEmpresa extends StatelessWidget {
  const historicoEmpresa({key});
  

  Future<historico> recuperarHitorico() async {
    var headers = {
      'X-API-KEY': 'API_KEY'
    };
    final response = await http.get('https://yfapi.net/v8/finance/spark?interval=1d&range=10d&symbols=AAPL',headers: headers);
    print(response.statusCode);
    if (response != null) {
      if (response.body != null && response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          json = json['AAPL'];
          print (json);
          var detalles_historico = historico.fromJson(json);
          print(detalles_historico);
          return detalles_historico;
        }else if (response.statusCode == 401) {
          print("error");
          return null;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    recuperarHitorico();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de '),
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