import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:join/activity/geo_service.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String googleApikey = "AIzaSyBffT8plN_Vdcd308KgmzIfGVQN6q-CkAo";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  bool _isLoading = false;
  List latlong = [];
  String location = 'Please move map to A specific location.';
  TextEditingController _locationController = TextEditingController();
  BitmapDescriptor? customMarkerIcon;

  @override
  void initState() {
    fetchLocationData();

    getLatLong();
    loadCustomMarkerIcon();

    super.initState();
  }

  @override
  void dispose() {
    //  searchController.dispose();
    super.dispose();
  }

  void getLatLong() async {
    setState(() {
      _isLoading = true;
    });
    latlong = await getLocation().getLatLong();
    setState(() {
      latlong;
      _isLoading = false;
    });
  }

  Future<void> loadCustomMarkerIcon() async {
    final String markerIconPath = 'assets/user_loc.png';
    final ByteData byteData = await rootBundle.load(markerIconPath);
    final Uint8List byteList = byteData.buffer.asUint8List();

    setState(() {
      customMarkerIcon = BitmapDescriptor.fromBytes(byteList);
    });
  }

  List<Marker> markers = [];

  Future<void> fetchLocationData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('activity')
        .where("activity", isEqualTo: "Creative Activities")
        .get();
    setState(() {
      markers = querySnapshot.docs.map((doc) {
        double latitude = doc['latitude'];
        double longitude = doc['longitude'];
        return Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(latitude, longitude),
          icon: customMarkerIcon!,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng startLocation = _isLoading
        ? const LatLng(51.1657, 10.4515)
        : LatLng(latlong[0], latlong[1]);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(19, 246, 246, 244),
        title: Text(
          "Creative Activities",
          style: TextStyle(
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Color(0xff160F29)),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: startLocation, //initial position
          zoom: 14.0, //initial zoom level
        ),
        markers: Set<Marker>.of(markers),
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
        onCameraMove: (CameraPosition cameraPositiona) {
          cameraPosition = cameraPositiona; //when map is dragging
        },
        onCameraIdle: () async {
          List<Placemark> addresses = await placemarkFromCoordinates(
              cameraPosition!.target.latitude,
              cameraPosition!.target.longitude);

          var first = addresses.first;
          print("${first.name} : ${first..administrativeArea}");

          List<Placemark> placemarks = await placemarkFromCoordinates(
              cameraPosition!.target.latitude,
              cameraPosition!.target.longitude);
          Placemark place = placemarks[0];
          location =
              '${place.street},${place.subLocality},${place.locality},${place.thoroughfare},';

          setState(() {
            //get place name from lat and lang
            // print(address);
            _locationController.text = location;
          });
        },
      ),
    );
  }
}
