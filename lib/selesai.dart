import 'package:dio/dio.dart';
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

// ignore: missing_return
void putIjins(int id) async {
  // ignore: unused_local_variable
  var response = await http.put(
    Uri.parse('http://192.168.98.95:8000/api/status/$id'),
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );
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
  Future<List<Ijin>> _ijins;
  TextEditingController searchController = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');

  //   _SearchBarExampleState() {
  //   _filter.addListener(() {
  //     if (_filter.text.isEmpty) {
  //       setState(() {
  //         _searchText = '';
  //         filteredNames = names;
  //       });
  //     } else {
  //       setState(() {
  //         _searchText = _filter.text;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _ijins = getIjins2();
    _searchPressed();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: searchController,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredNames = names;
        //_filter.clear();
      }
    });
  }

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
                }),
            // IconButton(
            //     onPressed: () {
            //       _searchPressed();
            //     },
            //     icon: Icon(Icons.search))
          ],
          backgroundColor: Color(0xfffdd835),
        ),
        body: FutureBuilder(
            future: _ijins,
            //future: getIjins2(),
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
                                      putIjins(data[index].id);
                                      data.removeAt(index);
                                      _ijins = getIjins2();
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
