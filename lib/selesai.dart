import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ijin/home.dart';

class Ijin {
  final int id;
  final String nik;
  final String waktuIjin;
  final String waktuKembali;
  final String keterangan;
  final String mesin;

  Ijin({
    this.id,
    this.nik,
    this.waktuIjin,
    this.waktuKembali,
    this.keterangan,
    this.mesin,
  });

  factory Ijin.fromJson(Map<String, dynamic> json) {
    return Ijin(
      id: json['id'],
      nik: json['nik'],
      waktuIjin: json['waktu_ijin'],
      waktuKembali: json['waktu_kembali'],
      keterangan: json['keterangan'],
      mesin: json['mesin'],
    );
  }
}

// ignore: missing_return
Future<List<Ijin>> getIjins2() async {
  var response =
      await http.get(Uri.parse('http://192.168.98.95:8000/api/status'));
  // await http.put(Uri.parse('http://192.168.98.95:8000/api/status'));
  //print(json.decode(response.body));

  if (response.statusCode == 200) {
    // var data =
    // '{ "Global": { "NewConfirmed": 100282, "TotalConfirmed": 1162857, "NewDeaths": 5658, "TotalDeaths": 63263, "NewRecovered": 15405, "TotalRecovered": 230845 }, "Countries": [ { "Country": "ALA Aland Islands", "CountryCode": "AX", "Slug": "ala-aland-islands", "NewConfirmed": 0, "TotalConfirmed": 0, "NewDeaths": 0, "TotalDeaths": 0, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" },{ "Country": "Zimbabwe", "CountryCode": "ZW", "Slug": "zimbabwe", "NewConfirmed": 0, "TotalConfirmed": 9, "NewDeaths": 0, "TotalDeaths": 1, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" } ], "Date": "2020-04-05T06:37:00Z" }';
    print(response.body);
    var parsed = json.decode(response.body);
    print(parsed.length);
    // ignore: unused_local_variable
    List jsonResponse = parsed as List;
    print(parsed);
    return jsonResponse.map((job) => new Ijin.fromJson(job)).toList();
  } else {
    print('Error, Could not load Data.');
    throw Exception('Failed to load Data');
  }
}

Future<List<Ijin>> putIjins(int id) async {
  var response =
      await http.put(Uri.parse('http://192.168.98.95/8000/api/status/${id}'));
}

// ignore: must_be_immutable
class SelesaiPage extends StatefulWidget {
  var nik;
  var mesin;
  var keterangan;
  var waktuIjin;
  @override
  State<SelesaiPage> createState() => _SelesaiPageState();
}

class _SelesaiPageState extends State<SelesaiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("APLIKASI IZIN"),
          actions: [
            IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                })
          ],
          backgroundColor: Color(0xfffdd835),
        ),
        body: FutureBuilder(
            future: getIjins2(),
            builder: (context, snapshot) {
              List<Ijin> data = snapshot.data as List<Ijin>;
              if (snapshot.hasData) {
                print(snapshot.data);
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(
                            'NIK : ${data[index].nik}',
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Departemen :${data[index].mesin}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Keterangan : ${data[index].keterangan}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ]),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${data[index].waktuIjin}',
                              ),
                              GestureDetector(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.brown,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      data.removeAt(index);
                                      putIjins(data[index].id);
                                    });
                                  }),
                            ],
                          ));
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
