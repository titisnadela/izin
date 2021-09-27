// // import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // void main() {
// //   runApp(Supervisor());
// // }

// class SupervisorPage extends StatelessWidget {
//   const SupervisorPage({
//     Key key,
//   }) : super(key: key);

//   final String url = 'http://192.168.43.124:8000/api/ijins';

//   Future getIjins() async {
//     var response =
//         await http.get(Uri.parse('http://192.168.43.124:8000/api/ijins'));
//     print(json.decode(response.body));
//     return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         //backgroundColor: Color(0xfffdd835),
//         appBar: AppBar(
//           title: Text("APLIKASI IZIN"),
//           backgroundColor: Color(0xfffdd835),
//         ),
//         body: FutureBuilder(
//             future: getIjins(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {
//                       return DataTable(
//                         columns: <DataColumn>[
//                           DataColumn(label: Text('nik')),
//                           DataColumn(label: Text('waktu_ijin')),
//                           DataColumn(label: Text('mesin')),
//                           DataColumn(label: Text('keterangan')),
//                           DataColumn(label: Text('waktu_Kembali'))
//                         ],
//                         rows: <DataRow>[
//                           DataRow(cells: [
//                             DataCell(
//                                 Text(snapshot.data[index]['nik'].toString())),
//                             DataCell(Text(
//                                 snapshot.data[index]['waktu_ijin'].toString())),
//                             DataCell(
//                                 Text(snapshot.data[index]['mesin'].toString())),
//                             DataCell(Text(
//                                 snapshot.data[index]['keterangan'].toString())),
//                             DataCell(Text(snapshot.data[index]['waktu_kembali']
//                                 .toString()))
//                           ])
//                         ],
//                       );
//                     });
//               } else {
//                 return Text('Data Error');
//               }
//             }));
//   }
// }

//import 'dart:html';

//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<List<Ijin>> getIjins2() async {
  var response =
      await http.get(Uri.parse('http://192.168.98.95:8000/api/ijins'));
  //print(json.decode(response.body));

  if (response.statusCode == 200) {
    // var data =
    // '{ "Global": { "NewConfirmed": 100282, "TotalConfirmed": 1162857, "NewDeaths": 5658, "TotalDeaths": 63263, "NewRecovered": 15405, "TotalRecovered": 230845 }, "Countries": [ { "Country": "ALA Aland Islands", "CountryCode": "AX", "Slug": "ala-aland-islands", "NewConfirmed": 0, "TotalConfirmed": 0, "NewDeaths": 0, "TotalDeaths": 0, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" },{ "Country": "Zimbabwe", "CountryCode": "ZW", "Slug": "zimbabwe", "NewConfirmed": 0, "TotalConfirmed": 9, "NewDeaths": 0, "TotalDeaths": 1, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" } ], "Date": "2020-04-05T06:37:00Z" }';
    var parsed = json.decode(response.body);
    print(parsed.length);
    List jsonResponse = parsed as List;

    return jsonResponse.map((job) => new Ijin.fromJson(job)).toList();
  } else {
    print('Error, Could not load Data.');
    throw Exception('Failed to load Data');
  }
}

class SupervisorPage extends StatefulWidget {
  @override
  State<SupervisorPage> createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  final String url = 'http://192.168.98.95:8000/api/ijins';

  Future getIjins() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    //print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future<List<Ijin>> _func;

  void initState() {
    _func = getIjins2();
    // controller.addListener(onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("APLIKASI IZIN"),
          backgroundColor: Color(0xfffdd835),
        ),
        body: FutureBuilder(
            future: _func,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                List<Ijin> data = snapshot.data as List<Ijin>;
                return PaginatedDataTable(
                    // physics: ClampingScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    // child: PaginatedDataTable(
                    rowsPerPage: 13,
                    columns: <DataColumn>[
                      DataColumn(label: Text('NIK')),
                      DataColumn(label: Text('Waktu Izin')),
                      DataColumn(label: Text('Mesin')),
                      DataColumn(label: Text('Keterangan')),
                      DataColumn(label: Text('Waktu Kembali'))
                    ],
                    source: UserDataTableSource(userData: data));
              } else {
                return Text('Data Error');
              }
            }));
  }
}

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    @required List<Ijin> userData,
  })  : _userData = userData,
        assert(userData != null);

  final List<Ijin> _userData;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    final _user = _userData[index];

    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${_user.nik}')),
      DataCell(Text('${_user.waktuIjin}')),
      DataCell(Text('${_user.mesin}')),
      DataCell(Text('${_user.keterangan}')),
      DataCell(Text('${_user.waktuKembali}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;
}
