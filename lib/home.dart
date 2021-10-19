import 'dart:convert';

import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:ijin/selesai.dart';
//import 'package:ijin/login.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
//import 'package:ijin/supervisor.dart';

class HomePage extends StatefulWidget {
  final String nik;
  final String email;
  final String token;
  HomePage({this.nik, this.email, this.token});

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TextEditingController nik = new TextEditingController();
  // TextEditingController mesinn = new TextEditingController();
  // TextEditingController keterangan = new TextEditingController();

  String waktu = "";
  String waktu1 = "";
  var time;

  String selectNIK = "";
  String selectMesin = "";
  String selectKet = "";

  List<String> nomor = ["n234", "m123", "1098"];
  List<String> mesinnn = [
    "CFM",
    "BUBUT",
    "ENGRAVE",
    "LAB",
    "PLATING",
    "PROFF",
    "QA",
    "WAREHOUSE"
  ];
  List<String> ket = ["SOLAT", "TOILET", "AMBIL BAHAN"];

  final nikSelected = TextEditingController();
  final mesinSelected = TextEditingController();
  final ketSelected = TextEditingController();

  // ignore: missing_return
  Future<List> _save() async {
    // ignore: unused_local_variable
    final response =
        await http.post(Uri.parse("http://192.168.98.95:8000/api/ijins"),
            headers: {
              // 'Authorization': 'Bearer ${widget.token}',
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode({
              "nik": selectNIK,
              "mesin": selectMesin,
              "keterangan": selectKet,
              "waktu_ijin": waktu,
              "waktu_kembali": waktu1,
              "status": 1
            }));
    print(response.body);
    if (response.statusCode != 201) {
      _showDialog(context);
    } else {
      setState(() {
        nikSelected.clear();
        mesinSelected.clear();
        ketSelected.clear();
        waktu = "";
        waktu1 = "";
      });
    }
    //print(response.body));
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

    // final nikhome = Container(
    //   child: Text(
    //     'NIK : ${widget.nik}',
    //     style: TextStyle(
    //         fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    //     textAlign: TextAlign.center,
    //   ),
    // );

    final nik = DropDownField(
      controller: nikSelected,
      hintText: "NIK",
      enabled: true,
      items: nomor,
      onValueChanged: (value) {
        setState(() {
          selectNIK = value;
        });
      },
      // textAlign: TextAlign.left,
      // decoration: InputDecoration(
      //   hintText: 'NIK',
      //   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      //   hintStyle: TextStyle(color: Colors.grey),
      // ),
      // style: TextStyle(color: Colors.black, fontSize: 20),
      // autofocus: false,
    );

    final mesin = DropDownField(
      controller: mesinSelected,
      hintText: "Departemen",
      enabled: true,
      items: mesinnn,
      onValueChanged: (value) {
        setState(() {
          selectMesin = value;
        });
      },
      // textAlign: TextAlign.left,
      // decoration: InputDecoration(
      //   hintText: 'Departemen',
      //   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      //   hintStyle: TextStyle(color: Colors.grey),
      // ),
      // style: TextStyle(color: Colors.black, fontSize: 20),
      // autofocus: false,
    );
    Padding(padding: EdgeInsets.all(10));
    final deskripsi = DropDownField(
      controller: ketSelected,
      hintText: "Keterangan",
      enabled: true,
      items: ket,
      onValueChanged: (value) {
        setState(() {
          selectKet = value;
        });
      },
      // decoration: InputDecoration(
      //   hintText: 'Keterangan',
      //   contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      //   hintStyle: TextStyle(color: Colors.grey),
      // ),
      // style: TextStyle(color: Colors.black, fontSize: 20),
      // autofocus: false,
    );
    final ijin = Container(
      child: Row(
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color(0xfffbc02d),
              padding: EdgeInsets.symmetric(horizontal: 68, vertical: 8),
            ),
            onPressed: () {
              var time = DateFormat.yMd().add_jm().format(DateTime.now());
              setState(() {
                var time1 = DateTime.parse('0000-00-00 00:00:00');
                waktu1 = time1.toString();
                waktu = time.toString();
                _save();
              });
            },
            child: new Text(
              'IZIN',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Text(waktu),
        ],
      ),
    );
    // final kembali = Container(
    //   child: Row(
    //     children: <Widget>[
    //       TextButton(
    //         style: TextButton.styleFrom(
    //           backgroundColor: Color(0xfffbc02d),
    //           padding: EdgeInsets.symmetric(horizontal: 46, vertical: 8),
    //         ),
    //         onPressed: () {
    //           var time = DateFormat.yMd().add_jm().format(DateTime.now());
    //           setState(() {
    //             waktu1 = time.toString();
    //           });
    //         },
    //         child: Text(
    //           'SELESAI',
    //           style: TextStyle(color: Colors.white, fontSize: 25),
    //         ),
    //       ),
    //       Padding(padding: EdgeInsets.only(left: 20)),
    //       Text(waktu1)
    //     ],
    //   ),
    // );

    // final save = Padding(
    //   padding: EdgeInsets.symmetric(vertical: 16.0),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(30.0),
    //     shadowColor: Colors.lightBlueAccent.shade100,
    //     elevation: 5.0,
    //     child: MaterialButton(
    //       minWidth: 200.0,
    //       height: 42.0,
    //       onPressed: () {
    //         _save();
    //       },
    //       color: Color(0xfffdd835),
    //       child: Text('SIMPAN', style: TextStyle(color: Colors.white)),
    //     ),
    //   ),
    // );

    // final data = Padding(
    //   padding: EdgeInsets.symmetric(vertical: 16.0),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(30.0),
    //     shadowColor: Colors.lightBlueAccent.shade100,
    //     elevation: 5.0,
    //     child: MaterialButton(
    //       minWidth: 200.0,
    //       height: 42.0,
    //       onPressed: () {
    //         Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           return SupervisorPage();
    //         }));
    //       },
    //       color: Color(0xff827717),
    //       child: Text('Data karyawan izin',
    //           style: TextStyle(color: Colors.white, fontSize: 15)),
    //     ),
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
        leading: new IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SelesaiPage();
                  },
                )),
            icon: Icon(Icons.arrow_back)),
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.logout),
        //       onPressed: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return HomePage();
        //         }));
        //       })
        // ],
        backgroundColor: Color(0xfffdd835),
      ),
      body: Center(
        child: ListView(
          // shrinkWrap: true,
          padding: EdgeInsets.only(left: 24, right: 24),
          children: <Widget>[
            logo,
            SizedBox(height: 20),
            // nikhome,
            // SizedBox(height: 10),
            nik,
            SizedBox(height: 10),
            mesin,
            SizedBox(height: 10),
            deskripsi,
            SizedBox(height: 10),
            ijin,
            SizedBox(height: 10),
            // kembali,
            // SizedBox(height: 10),
            //save,
            //data,
            SizedBox(height: 10),
            //data
          ],
        ),
      ),
    ));
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Form Izin'),
          content: new Text('Mohon formulir diisi dengan benar.'),
          actions: [
            // ignore: deprecated_member_use
            new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('Coba Lagi!'))
          ],
        );
      });
}
