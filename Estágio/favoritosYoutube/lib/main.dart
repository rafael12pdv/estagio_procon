import 'package:favoritosyoutube/screns/home.dart';
import 'package:flutter/material.dart';

import 'api.dart';

void main() {
  Api api = Api();
  api.search("eletro");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tube',
      home: Home(),
    );
  }
}
