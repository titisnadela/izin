import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  //static String tag;
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nik3 = new TextEditingController();
  TextEditingController email3 = new TextEditingController();
  TextEditingController password3 = new TextEditingController();
  TextEditingController password4 = new TextEditingController();

  // ignore: missing_return
  Future<List> _register() async {
    final response =
        await http.post(Uri.parse("http://192.168.98.95:8000/api/register"),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({
              "nik": nik3.text,
              "email": email3.text,
              "password": password3.text,
              "password_confirmation": password4.text
            }));

    if (response.statusCode != 201) {
      setState(() {
        _showAlertDialog(context);
      });
    } else {
      Navigator.pushReplacementNamed(context, '/MainPage');
    }
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'PMR',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/PMR.png'),
      ),
    );

    final nik = TextFormField(
      controller: nik3,
      decoration: InputDecoration(
        hintText: 'NIK',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      //obscureText: true,
      autofocus: false,
    );

    final email = TextFormField(
      controller: email3,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      autofocus: false,
    );

    final password = TextFormField(
      controller: password3,
      decoration: InputDecoration(
        hintText: 'Kata Sandi',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      obscureText: true,
      autofocus: false,
    );

    final passwordConfirmation = TextFormField(
      controller: password4,
      decoration: InputDecoration(
        hintText: 'Ulang Kata Sandi',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      obscureText: true,
      autofocus: false,
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _register();
          },
          color: Color(0xfffdd835),
          child: Text('Daftar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(
              height: 48.0,
            ),
            nik,
            SizedBox(
              height: 8.0,
            ),
            email,
            SizedBox(
              height: 8.0,
            ),
            password,
            SizedBox(
              height: 8.0,
            ),
            passwordConfirmation,
            SizedBox(
              height: 24.0,
            ),
            //passwordconf,
            SizedBox(
              height: 8.0,
            ),
            registerButton,
          ],
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Form Registration'),
          content: new Text('Please fill in the registration form correctly!'),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Try again?'))
          ],
        );
      });
}
