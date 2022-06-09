import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'modelos/historico.dart';
import 'main.dart';

class historicoEmpresa extends StatefulWidget {
  historicoEmpresa({Key key, this.nombre, this.clave}) : super(key: key);
  final String nombre;
  final String clave;

  @override
  _historicoEmpresaState createState() {
    return new _historicoEmpresaState(nombre,clave);
  }
}

class _historicoEmpresaState extends State<historicoEmpresa> {
  String nombre;
  String clave;

  _historicoEmpresaState(String nombre, String clave){
    this.nombre = nombre;
    this.clave = clave;
  }

  historico detalleHistorico = null;
  bool finalizoServicio = false;

  Future<historico> recuperarHitorico() async {
    var headers = {
      'X-API-KEY': 'API_KEY'
    };
    final response = await http.get('https://yfapi.net/v8/finance/spark?interval=1d&range=10d&symbols='+clave,headers: headers);
    print(response.statusCode);
    if (response != null) {
      if (response.body != null && response.body.isNotEmpty) {
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          json = json[clave];
          print (json);
          var detalles_historico = historico.fromJson(json);
          print(detalles_historico);
          return detalles_historico;
        }else if (response.statusCode == 401) {
          print("error");
          return null;
        }
        else if (response.statusCode == 429) {
          print("error");
          return null;
        }
      }
    }
  }

  Widget loading(){
    return Center(
      child: CircularProgressIndicator(
        value: null,
        semanticsLabel: 'Linear progress indicator',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(finalizoServicio == false){recuperarHitorico().then((val) => setState((){
      detalleHistorico = val;
      finalizoServicio = true;
    }));}
    return Scaffold(
      appBar: AppBar(
        title: Text('Historico de ' + nombre),
      ),
      body: finalizoServicio ? Center(
        child: detalleHistorico != null ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text("Revisar el historial de los ultimos 10 dias de: " + detalleHistorico.symbol),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Fecha:"),
                  Text("Cierre")
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: detalleHistorico.timestamp.length,
                  itemBuilder: (context, index){
                    var fecha = DateTime.fromMillisecondsSinceEpoch(detalleHistorico.timestamp[index] * 1000);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(fecha.day.toString() + "/" + fecha.month.toString() + "/" + fecha.year.toString()),
                        Text(detalleHistorico.close[index].toString())
                      ],
                    );
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Regresar"),
                ),
                FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()),);
                  },
                  child: const Text("Salir"),
                ),
              ],
            ),
          ],
        ) : Text("Hubo un error en el servicio"),
      ) : loading(),
    );
  }
}