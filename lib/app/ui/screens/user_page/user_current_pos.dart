// import 'package:flutter/material.dart';
// import 'package:flutter_app/app/logic/config/app_module.dart';
// import 'package:geolocator/geolocator.dart';

// class UserCurrentPos extends StatefulWidget {
//   @override
//   _UserCurrentPosState createState() => _UserCurrentPosState();
// }

// class _UserCurrentPosState extends State<UserCurrentPos> {
//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//   }

//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 "Your Cordinates",
//                 style: AppModule.mediumText,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "LAT :, LONG: ",
//                 style: AppModule.regularText,
//               ),
//               SizedBox(
//                 height: 26,
//               ),
//               Text(
//                 "Your Places Address",
//                 style: AppModule.mediumText,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Your Places Address",
//                 style: AppModule.regularText,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               MaterialButton(
//                 color: Colors.yellow,
//                 onPressed: () {
//                   _determinePosition();
//                 },
//                 child: Text("Get Location"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
