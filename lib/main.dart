//import 'dart:js';

import 'package:flutter/material.dart';
import 'login.dart';
//import 'package:ijin/home.dart';
//import 'package:ijin/login.dart';
//import 'package:ijin/register.dart';

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
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/Home': (BuildContext context) => LoginPage(),
          '/MainPage': (BuildContext context) => LoginPage()
        });
  }
}
