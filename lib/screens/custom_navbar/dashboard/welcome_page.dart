import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:join/chat_views/views/send_notification.dart';
import 'package:join/screens/custom_navbar/dashboard/widgets/show_custom_dialog.dart';
import 'package:join/screens/custom_navbar/dashboard/widgets/welcome_screen_header.dart';

import '../../activities/activity/geo_service.dart';
import '../../filters/filters.dart';
import '../../friends/friends_screen.dart';
import '../../notification/notiy.dart';
import '../../requests/request_screen.dart';

//todo please fix padding problem
class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  String googleApikey = "AIzaSyBffT8plN_Vdcd308KgmzIfGVQN6q-CkAo";
  GoogleMapController? mapController;
  CameraPosition cameraPosition = const CameraPosition(target: LatLng(51.1657, 10.4515));
  bool _isLoading = false;
  List latlong = [];
  String location = 'Please move map to A specific location.';
  final TextEditingController _locationController = TextEditingController();
  BitmapDescriptor? customMarkerIcon;
  final Completer<GoogleMapController> _completer = Completer();

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await getUserCurrentLocation().then((value) async {
      print("value.latitude:${value.latitude}");
      markers.add(Marker(markerId: MarkerId("2"), position: LatLng(value.latitude, value.longitude)));
      CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 14);

      await loadCustomMarkerIcon();
      await fetchLocationData();
      await getLatLong();
      mapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition)).then((value) {
        print('animated');
      });
      setState(() {});
    });
    SendNotification().updateToken();
  }

  @override
  void dispose() {
    //  searchController.dispose();
    super.dispose();
  }

  getLatLong() async {
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
    String markerIconPath = 'assets/user_loc.png';
    final ByteData byteData = await rootBundle.load(markerIconPath);
    final Uint8List byteList = byteData.buffer.asUint8List();

    setState(() {
      customMarkerIcon = BitmapDescriptor.fromBytes(byteList);
    });
  }

  List<Marker> markers = [];

  Future<void> fetchLocationData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('activity').get();
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
    LatLng startLocation = _isLoading ? const LatLng(51.1657, 10.4515) : LatLng(latlong[0], latlong[1]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 182),
        child: AppBar(
          backgroundColor: const Color.fromARGB(19, 246, 246, 244),
          elevation: 6,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
          title: const Text(
            "Welcome to JOIN",
            style: TextStyle(fontFamily: "ProximaNova", fontWeight: FontWeight.w700, fontSize: 17, color: Color(0xff160F29)),
            overflow: TextOverflow.ellipsis,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/yellow.png",
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => Filters()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/right.png"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => Noti()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/noti.png"),
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestScreen()));
                },
                child: const Icon(Icons.person)),
            const SizedBox(width: 20),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var userList = snapshot.data!.data() as Map<String, dynamic>;
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FriendsScreen(
                              userList: userList['friends'],
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.group));
                }),
          ],
          flexibleSpace: const WelcomeScreenHorizontalHeader(),
        ),
      ),
      body: SizedBox(
        height: 600,
        child: Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              markers: Set<Marker>.of(markers),
              mapType: MapType.normal, //map type
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona;
              },
              onCameraIdle: () async {
                List<Placemark> addresses = await placemarkFromCoordinates(cameraPosition.target.latitude, cameraPosition.target.longitude);

                var first = addresses.first;
                print("${first.name} : ${first..administrativeArea}");

                List<Placemark> placemarks =
                    await placemarkFromCoordinates(cameraPosition.target.latitude, cameraPosition.target.longitude);
                Placemark place = placemarks[0];
                location = '${place.street},${place.subLocality},${place.locality},${place.thoroughfare},';

                setState(() {
                  _locationController.text = location;
                });
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 80),
                height: 34,
                width: 94,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      showMyDialog(context);
                    },
                    child: const Text(
                      "List View",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    await Geolocator.requestPermission().then((value) async {
      print('getUserCurrentLocation:$value:${await Geolocator.getCurrentPosition()}');
    }).onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
