import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vet_pharma/services/employee_management_services.dart';
import 'package:vet_pharma/utils/helper.dart';
import 'package:vet_pharma/widgets/appbar.dart';

class MapScreen extends StatefulWidget {
  final String userId;

  MapScreen({required this.userId});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Map<String, dynamic>> locations = [];
  List<LatLng> points = [];
  DateTime selectedDate = DateTime.now();
  Timer? _timer;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      _loadLocations();
    }
  }

  Future<void> _showLocationDetails(BuildContext context, LatLng point, String timeString) async {
    // Fetch the address from the coordinates
    // List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
    // Placemark place = placemarks[0];

    // String address = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

    // Show a dialog with the address and time
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Longitude: ${point.longitude} ",style: TextStyle(color: Colors.black),),
            const  SizedBox(height: 10),
              Text("Latitude: ${point.longitude} ",style: TextStyle(color: Colors.black),),
            const  SizedBox(height: 10),
              Text("Time: ${convertTimeStamp(timeString)}",style: TextStyle(color: Colors.black),),
              Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff596cff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: () async {
                openMap(point.latitude ?? 22.00,
                    point.longitude ?? 22.00);
              },
              child: const Text("Open Map", style: const TextStyle(
                color: Colors.white
              ))),
        ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadLocations();
    _timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      _loadLocations();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  var isLoading = false;
  Future<void> _loadLocations() async {
    setState(() {
      isLoading = true;
    });
    final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<Map<String, dynamic>> fetchedLocations =
        await EmployeeManagementServices.getEmployeeLocation(
            widget.userId, dateString);
    setState(() {
      locations = fetchedLocations;
      points = locations.map((location) {
        return LatLng(location['latitude'], location['longitude']);
      }).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:AppBars(context),
    appBar:      AppBar(
       backgroundColor: const Color(0xff596cff),
          title: const Text('Map'),
          actions: [
            IconButton(
              icon: const Icon(Icons.date_range),
              onPressed: () => _selectDate(
                  context), // Open DatePicker when the icon is pressed
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: points.isNotEmpty
                          ? points[0]
                          : const LatLng(26.4525, 87.2718),
                      initialZoom: 14.2,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: "com.example.vet_pharma",
                      ),
                      // PolylineLayer(
                      //   polylines: [
                      //     Polyline(
                      //       points: points,
                      //       strokeWidth: 4.0,
                      //       color: Colors.blue,
                      //     ),
                      //   ],
                      // ),
                      MarkerLayer(
                        markers: points.asMap().entries.map((entry) {
                          final index = entry.key;
                          final point = entry.value;
                          final location = locations.firstWhere(
                            (loc) =>
                                loc['latitude'] == point.latitude &&
                                loc['longitude'] == point.longitude,
                          );
                          final timeString = location['timeStamp'];
                          return Marker(
                            key: ValueKey(
                                index), // Use a unique key for each marker
                            width: 80.0,
                            height: 80.0,
                            point: point,
                            child: InkWell(
                              onTap: () {
                                _showLocationDetails(context, point, timeString);
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                            onTap: () => launchUrl(Uri.parse(
                                'https://openstreetmap.org/copyright')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ));
  }
}


// import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:latlong2/latlong.dart';
// import 'package:vet_pharma/services/employee_management_services.dart';
// import 'package:vet_pharma/utils/helper.dart';

// class MapScreen extends StatefulWidget {
//   final String userId;

//   MapScreen({required this.userId});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   List<Map<String, dynamic>> locations = [];
//   List<Marker> markers = []; // List to store markers for Google Maps
//   DateTime selectedDate = DateTime.now();
//   GoogleMapController? mapController;

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
//     try {
//       final dateString = DateFormat('yyyy-MM-dd').format(selectedDate);
//     List<Map<String, dynamic>> fetchedLocations = await EmployeeManagementServices.getEmployeeLocation(widget.userId, dateString);
//     setState(() {
//       locations = fetchedLocations;
//       markers = locations.map((location) {
//         LatLng point = LatLng(location['latitude'], location['longitude']);
//         final timeString = location['timestamp']??"";
        
//         return Marker(
//           markerId: MarkerId('${point.longitude}${point.longitude}$timeString'), // Unique ID for each marker
//           position: point,
//           icon: BitmapDescriptor.defaultMarker, // Default marker icon
//           infoWindow: InfoWindow(
//             title:timeString.isNotEmpty? convertToTime(timeString):timeString, // Display time in info window
//           ),
//         );
//       }).toList();
//     });
//       if (locations.isNotEmpty) {
//         LatLng firstLocation = LatLng(locations[0]['latitude'], locations[0]['longitude']);
//         mapController?.animateCamera(CameraUpdate.newLatLng(firstLocation));
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.date_range),
//             onPressed: () => _selectDate(context),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: locations.isNotEmpty ? LatLng(locations[0]['latitude'], locations[0]['longitude']) :const LatLng(26.4525, 87.2718),
//               zoom: 20.0,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
          
//             markers: markers.toSet(), // Convert markers list to a Set (required by Google Maps)
//           ),
//         ],
//       ),
//     );
//   }
// }