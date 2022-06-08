import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demostracion finanzas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demo Finanzas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool validacionCurp (String curp) {
    return RegExp(
        r"[A-Z]{1}[AEIOU]{1}[A-Z]{2}[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[HM]{1}(AS|BC|BS|CC|CS|CH|CL|CM|DF|DG|GT|GR|HG|JC|MC|MN|MS|NT|NL|OC|PL|QT|QR|SP|SL|SR|TC|TS|TL|VZ|YN|ZS|NE)" +
            "[B-DF-HJ-NP-TV-Z]{3}[0-9A-Z]{1}[0-9]{1}")
        .hasMatch(curp);
  }

  bool validacionEmail (String mail) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+")
        .hasMatch(mail);
  }

  mostrarAlerta (){
     showDialog(
       context: context,
       builder: (_) =>  AlertDialog(
        title: Text("Error"),
        content: Text("Verifique que los datos esten llenados correctamente, la CURP es en mayusculas"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          )
        ],
    ),
     );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController curp = new TextEditingController();
    TextEditingController email = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Captura los datos para ingresar:',
            ),
            Center(
                child:  Padding( padding: EdgeInsets.all(9.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                      controller: curp,
                        maxLength: 18,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Ingrese CURP',
                          labelText: 'CURP',
                        ),
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.alternate_email),
                          hintText: 'Ingrese correo electronico',
                          labelText: 'correo electronico',
                        ),
                      ),
                      CupertinoButton(
                          child: Text("Ingresar", style: TextStyle(color: Colors.black),),
                          onPressed: (){
                            if(validacionEmail(email.text) && validacionCurp(curp.text)){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const menu()),);
                            }else{
                              mostrarAlerta();
                            }
                          })
                    ],
                  ),
                )
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
