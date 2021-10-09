// //import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:ijin/home.dart';
// import 'package:ijin/selesai.dart';
// //import 'package:ijin/supervisor.dart';
// //import 'package:ijin/home.dart';

// class PertamaPage extends StatelessWidget {
//   // const PertamaPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final logo = Hero(
//       tag: 'PMR',
//       child: CircleAvatar(
//         backgroundColor: Colors.transparent,
//         radius: 48.0,
//         child: Image.asset('assets/PMR.png'),
//       ),
//     );
//     final izin = Container(
//       child: Row(
//         children: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Color(0xfffbc02d),
//               padding: EdgeInsets.symmetric(horizontal: 88, vertical: 8),
//             ),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return HomePage();
//               }));
//             },
//             child: new Text(
//               'IZIN',
//               style: TextStyle(fontSize: 25, color: Colors.white),
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(left: 20)),
//         ],
//       ),
//     );

//     final kembali = Container(
//       child: Row(
//         children: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Color(0xfffbc02d),
//               padding: EdgeInsets.symmetric(horizontal: 68, vertical: 8),
//             ),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return SelesaiPage();
//               }));
//             },
//             child: new Text(
//               'SELESAI',
//               style: TextStyle(fontSize: 25, color: Colors.white),
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(left: 20)),
//         ],
//       ),
//     );

//     // final data = Padding(
//     //   padding: EdgeInsets.symmetric(vertical: 16.0),
//     //   child: Material(
//     //     borderRadius: BorderRadius.circular(30.0),
//     //     shadowColor: Colors.lightBlueAccent.shade100,
//     //     elevation: 5.0,
//     //     child: MaterialButton(
//     //       minWidth: 200.0,
//     //       height: 42.0,
//     //       onPressed: () {
//     //         Navigator.push(context, MaterialPageRoute(builder: (context) {
//     //           return SupervisorPage();
//     //         }));
//     //       },
//     //       color: Color(0xff827717),
//     //       child: Text('Data karyawan izin',
//     //           style: TextStyle(color: Colors.white, fontSize: 15)),
//     //     ),
//     //   ),
//     // );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.only(left: 24, right: 24),
//           children: <Widget>[
//             logo,
//             SizedBox(height: 60),
//             izin,
//             SizedBox(height: 20),
//             kembali,
//             SizedBox(height: 20),
//             // data
//           ],
//         ),
//       ),
//     );
//   }
// }
