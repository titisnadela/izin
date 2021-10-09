//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ijin/selesai.dart';

void main() => runApp(IjinApp());

class IjinApp extends StatelessWidget {
  // final routes = <String, WidgetBuilder>{
  //   LoginPage.tag: (context) => LoginPage(),
  //   HomePage.tag: (context) => HomePage(),
  //   RegisterPage.tag (context) => RegisterPage()
  // };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ijin App',
        debugShowCheckedModeBanner: false,
        home: SelesaiPage(),
        routes: <String, WidgetBuilder>{
          '/Home': (BuildContext context) => SelesaiPage(),
          //'/MainPage': (BuildContext context) => PertamaPage()
        });
  }
}
