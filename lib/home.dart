//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ijin/login.dart';
//import 'package:ijin/supervisor.dart';
//import 'package:ijin/supervisor.dart';
// import 'package:ijin/login.dart';
// import 'package:ijin/home.dart';

class HomePage extends StatefulWidget {
  final String nik;
  final String email;
  HomePage({this.nik, this.email});

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final nikhome = Text(
      'NIK : N123',
      style: TextStyle(fontSize: 20, color: Colors.black),
    );

    final mesin = TextFormField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: 'Mesin',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      autofocus: false,
    );
    Padding(padding: EdgeInsets.all(10));
    final deskripsi = TextFormField(
      decoration: InputDecoration(
        hintText: 'Keterangan',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      autofocus: false,
    );
    final ijin = Container(
      child: Row(
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xfffdd835),
              padding: EdgeInsets.symmetric(horizontal: 68, vertical: 8),
            ),
            onPressed: () {},
            child: Text(
              'IZIN',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(
            '11.45',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
    final kembali = Container(
      child: Row(
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xfffdd835),
              padding: EdgeInsets.symmetric(horizontal: 42, vertical: 8),
            ),
            onPressed: () {},
            child: Text(
              'KEMBALI',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(
            '12.45',
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
    // final data = TextButton(
    //   style: TextButton.styleFrom(
    //     backgroundColor: Color(0xfffdd835),
    //     padding: EdgeInsets.symmetric(horizontal: 42, vertical: 8),
    //   ),
    //   onPressed: () {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       return SupervisorPage();
    //     }));
    //   },
    //   child: Text(
    //     'Data',
    //     style: TextStyle(color: Colors.white, fontSize: 25),
    //   ),
    // );

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "APLIKASI IZIN",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              })
        ],
        backgroundColor: Color(0xfffdd835),
      ),
      body: Center(
        child: ListView(
          // shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: <Widget>[
            SizedBox(height: 20),
            nikhome,
            SizedBox(height: 10),
            mesin,
            SizedBox(height: 10),
            deskripsi,
            SizedBox(height: 10),
            ijin,
            SizedBox(height: 10),
            kembali,
            //data
          ],
        ),
      ),
    ));
  }
}
