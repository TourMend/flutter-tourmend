import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(28.260075, 83.970093));

  GoogleMapController _mapController;

  final List<Marker> _markers = [
    Marker(
      position: LatLng(28.260075, 83.970093),
      markerId: MarkerId('intial_marker'),
      infoWindow: InfoWindow(
          title: "Gandaki College of Engineering and Science",
          snippet: 'G.C.E.S'),
    )
  ];

  void _addMarker(position) {
    var id = Random().nextInt(100);

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(id.toString()),
            position: position,
            infoWindow:
                InfoWindow(title: id.toString(), snippet: position.toString())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) =>
            setState(() => _mapController = controller),
        onTap: (position) {
          _mapController.animateCamera(CameraUpdate.newLatLng(position));
          _addMarker(position);
        },
        markers: _markers.toSet(),
      ),
    );
  }
}
