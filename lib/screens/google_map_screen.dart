// import 'package:flutter/material.dart';

// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:vet_pharma/services/employee_management_services.dart';


// class MapScreen extends StatefulWidget {
//   final String userId;

//   MapScreen({required this.userId});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   List<Map<String, dynamic>> locations = [];
//   List<LatLng> points = [];
//   DateTime selectedDate = DateTime.now();
//   GoogleMapController? mapController;
//   Set<Marker> markers = {};
//   bool isLoading = false;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//       _loadLocations();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadLocations();
//   }

//   Future<void> _loadLocations() async {
//     setState(() {
//       isLoading = true;
//     });
//     final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//     List<Map<String, dynamic>> fetchedLocations = await EmployeeManagementServices.getEmployeeLocation(widget.userId, dateString);

//     setState(() {
//       locations = fetchedLocations;
//       points = locations.map((location) {
//         return LatLng(location['latitude'], location['longitude']);
//       }).toList();
//       markers = points.map((point) {
//         final location = locations.firstWhere(
//           (loc) => loc['latitude'] == point.latitude && loc['longitude'] == point.longitude,
//         );
//         final timeString = location['timestamp'];
//         return Marker(
//           markerId: MarkerId(point.toString()),
//           position: point,
//           infoWindow: InfoWindow(
//             title: 'Timestamp',
//             snippet: convertToTime(timeString),
//           ),
          
//         );
//       }).toSet();
//       isLoading = false;
//     });
//   }

//   String convertToTime(String timestamp) {
//     // Implement your timestamp to time conversion logic
//     return timestamp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.date_range),
//             onPressed: () => _selectDate(context), // Open DatePicker when the icon is pressed
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//               initialCameraPosition: CameraPosition(
//                 target: points.isNotEmpty ? points[0] : const LatLng(26.4525, 87.2718),
//                 zoom: 9.2,
//               ),
//               markers: markers,
//               polylines: {
//                 Polyline(
//                   polylineId: const PolylineId('route'),
//                   points: points,
//                   color: Colors.blue,
//                   width: 4,
//                 ),
//               },
//             ),
//     );
//   }
// }
