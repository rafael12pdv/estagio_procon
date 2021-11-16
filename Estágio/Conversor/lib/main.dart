import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=ab6c1106";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.blueAccent, primaryColor: Colors.white),
  ));
}


Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text("Carregando dados",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,)
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text("Erro ao retornar dados",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0),
                      textAlign: TextAlign.center,)
                    );
                  } else {
                    dolar = snapshot.data!["results"] ["currencies"]["USD"]["buy"];
                    euro = snapshot.data!["results"] ["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150, color: Colors.amber),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Reais",
                                labelStyle: TextStyle(color: Colors.blueAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                prefixText: "R\$"
                            ),
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 25),
                          ),
                          Divider(),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Dólares",
                                labelStyle: TextStyle(color: Colors.blueAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                prefixText: "US\$"
                            ),
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 25),
                          ),
                          Divider(),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Euros",
                                labelStyle: TextStyle(color: Colors.blueAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.blueAccent),
                                ),
                                prefixText: "€"
                            ),
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 25),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
