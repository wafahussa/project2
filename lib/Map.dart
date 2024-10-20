// ignore_for_file: unused_local_variable, unnecessary_null_comparison, unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapL extends StatefulWidget {
  MapL({super.key});

  @override
  State<MapL> createState() => _MapLState();
}

class _MapLState extends State<MapL> {
  Position? cl;
  var lat;
  var long;

  Future<bool> getper() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    if (!services) {
      print("Location services are disabled.");
      return false;
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if (per == LocationPermission.denied) {
        print("Location permissions are denied.");
        return false;
      }
    }
    if (per == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return false;
    }
    return true;
  }

  Future<void> getlandl() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl?.latitude;
    long = cl?.longitude;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getper().then((hasPermission) {
      if (hasPermission) {
        getlandl();
      }
    });
  }

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(21.581060, 39.126642);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('lane1'),
      position: LatLng(21.599680, 39.167175),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('lane3'),
      position: LatLng(21.581060, 39.126642),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('lane4'),
      position: LatLng(21.595266, 39.156016),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('lane5'),
      position: LatLng(21.583295, 39.148973),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('lane6'),
      position: LatLng(21.600799, 39.142778),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('lane7'),
      position: LatLng(221.599842, 39.157035),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId('pothole1'),
      position: LatLng(21.457552, 39.223091),
      infoWindow: InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId('cracks2'),
      position: LatLng(21.606704, 39.130937),
      infoWindow: InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId('cracks5'),
      position: LatLng(21.581858, 39.171476),
      infoWindow: InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId('cracks4'),
      position: LatLng(21.584252, 39.148458),
      infoWindow: InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId('pothole2'),
      position: LatLng(21.596330, 39.138896),
      infoWindow: InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: const MarkerId('pothole5'),
      position: const LatLng(21.598884, 21.598884),
      infoWindow: const InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId('pothole9'),
      position: LatLng(21.599203, 39.168773),
      infoWindow: InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId('lane2'),
      position: LatLng(21.593936, 39.152810),
      infoWindow: InfoWindow(
        title: 'Lane ',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('pothole3'),
      position: const LatLng(21.599203, 39.168773),
      infoWindow: const InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId('pothole4'),
      position: LatLng(21.599522, 39.122405),
      infoWindow: InfoWindow(
        title: 'Pothole',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
    Marker(
      markerId: MarkerId('cracks3'),
      position: LatLng(21.586221, 39.148458),
      infoWindow: InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId('10'),
      position: LatLng(21.594308, 39.152912),
      infoWindow: InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: const MarkerId('cracks6'),
      position: const LatLng(21.594308, 39.152912),
      infoWindow: const InfoWindow(
        title: 'Cracks',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _showColorPicker(LatLng latLng) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            child: Column(
              children: [
                Expanded(
                  child: ListTile(
                    leading: const Icon(Icons.circle, color: Colors.red),
                    title: const Text('Lanes'),
                    onTap: () {
                      Navigator.pop(context);
                      // تمرير اسم المشكلة
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(Icons.circle, color: Colors.blue),
                    title: const Text('Pothole'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: ListTile(
                    leading: const Icon(Icons.circle, color: Colors.yellow),
                    title: const Text('Cracks'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: 500,
          height: 500,
          child: Column(
            children: [
              cl == null
                  ? const CircularProgressIndicator()
                  : Container(
                      height: 450,
                      width: 500,
                      child: GoogleMap(
                        onTap: (LatLng latLng) {
                          _showColorPicker(latLng);
                        },
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 14.0,
                        ),
                        markers: _markers,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
