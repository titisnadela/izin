import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ijin/home.dart';
import 'package:ijin/register.dart';
import 'package:ijin/supervisor.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email2 = new TextEditingController();
  TextEditingController password2 = new TextEditingController();

  String email1;
  String nik;

  // ignore: missing_return
  Future<List> _login() async {
    final response = await http.post(
        Uri.parse("http://192.168.98.95:8000/api/login"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({"email": email2.text, "password": password2.text}));

    var datauser = jsonDecode(response.body);

    print(datauser);
    if (datauser['user'] == null) {
      setState(() {
        _showAlertDialog(context);
      });
    } else {
      nik = datauser['nik'];
      email1 = datauser['email'];
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomePage(nik: nik, email: email1);
      }));
      print(response.body);
    }
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

    final email = TextFormField(
      controller: email2,
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
      controller: password2,
      autofocus: false,
      //initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Kata Sandi',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20),
      //autofocus: false,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            return _login();
            // }));
          },
          color: Color(0xfffdd835),
          child: Text('Masuk', style: TextStyle(color: Colors.white)),
        ),
      ),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegisterPage();
            }));
          },
          color: Color(0xfffdd835),
          child: Text('Daftar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    final data = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SupervisorPage();
            }));
          },
          color: Color(0xff827717),
          child: Text('Data karyawan izin',
              style: TextStyle(color: Colors.white, fontSize: 15)),
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
            email,
            SizedBox(
              height: 8.0,
            ),
            password,
            SizedBox(
              height: 24.0,
            ),
            loginButton,
            registerButton,
            SizedBox(
              height: 24.0,
            ),
            data
            //forgotLabel
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
          title: new Text('Wrong email or password'),
          content: new Text('Please enter correct email or password'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Try again?'))
          ],
        );
      });
}
