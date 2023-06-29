import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:join/activities_panel/create.dart';
import 'package:join/activities_panel/intectualactivities.dart';
import 'package:join/activities_panel/physicalactivities.dart';
import 'package:join/activities_panel/relax.dart';
import 'package:join/activities_panel/sip_together.dart';
import 'package:join/activity/geo_service.dart';
import 'package:join/chat_views/views/send_notification.dart';
import 'package:join/filters/filters.dart';
import 'package:join/notification/notiy.dart';

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  State<WelComePage> createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  String googleApikey = "AIzaSyBffT8plN_Vdcd308KgmzIfGVQN6q-CkAo";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition cameraPosition=CameraPosition(target: LatLng(51.1657, 10.4515));
  bool _isLoading = false;
  List latlong = [];
  String location = 'Please move map to A specific location.';
  TextEditingController _locationController = TextEditingController();
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
    markers.add(Marker(
        markerId: MarkerId("2"),
        position: LatLng(value.latitude, value.longitude)));
    CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude), zoom: 14);
//    final GoogleMapController controller = await _completer.future;
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
    final String markerIconPath = 'assets/user_loc.png';
    final ByteData byteData = await rootBundle.load(markerIconPath);
    final Uint8List byteList = byteData.buffer.asUint8List();

    setState(() {
      customMarkerIcon = BitmapDescriptor.fromBytes(byteList);
    });
  }

  List<Marker> markers = [];

  Future<void> fetchLocationData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('activity').get();
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
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 182),
        child: AppBar(
          backgroundColor: Color.fromARGB(19, 246, 246, 244),
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          title: Text(
            "Welcome to JOIN",
            style: TextStyle(
                fontFamily: "ProximaNova",
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Color(0xff160F29)),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Filters()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/right.png"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Noti()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/noti.png"),
              ),
            ),
          ],
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => PhysicalActivities()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/pc1.png",
                          width: 50, height: 50, fit: BoxFit.cover),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Physical\nActivities",
                        style: TextStyle(
                            color: Color(0xff160F29).withOpacity(.8),
                            fontSize: 10,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => IntelacutualActivities()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/pc3.png",
                          width: 50, height: 50, fit: BoxFit.cover),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        style: TextStyle(
                            color: Color(0xff160F29).withOpacity(.8),
                            fontSize: 10,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w600),
                        "Interllectual\nActivities",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => SipTogether()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/pc5.png",
                          width: 50, height: 50, fit: BoxFit.cover),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        style: TextStyle(
                            color: Color(0xff160F29).withOpacity(.8),
                            fontSize: 10,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w600),
                        "Sip\nTogether",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Create()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/pc2.png",
                          width: 50, height: 50, fit: BoxFit.cover),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w600,
                          color: Color(0xff160F29).withOpacity(.8),
                        ),
                        "Creative\nActivities",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Relaxation()));
                  },
                  child: Column(
                    children: [
                      Image.asset("assets/pc4.png",
                          width: 50, height: 50, fit: BoxFit.cover),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          fontFamily: "ProximaNova",
                          color: Color(0xff160F29).withOpacity(.8),
                        ),
                        "Relaxation and\nLeisure Activities",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: 600,
        child: Stack(
          children: [
            GoogleMap(
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
                print('cameraPositiona:${cameraPositiona}');
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 80),
                height: 34,
                width: 94,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: _showMyDialog,
                    child: Text(
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          width: 500,
          height: 267,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              insetPadding: EdgeInsets.all(5),
              contentPadding: EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Icon(
                              Icons.close,
                              color: Color(0xffFF1919),
                              size: 9,
                            ),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFF1919).withOpacity(.20)),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/errors.png"),
                      ),
                      title: Text(
                        "Paddy O'Furniture",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                            color: Color(0xff736F7F),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              "House Party",
                              style: TextStyle(
                                  color: Color(0xff246A73), fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          width: 50,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xff368F8B).withOpacity(.10)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "House Party",
                              style: TextStyle(
                                  color: Color(0xff246A73), fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          width: 50,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xff368F8B).withOpacity(.10)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "House Party",
                              style: TextStyle(
                                  color: Color(0xff246A73), fontSize: 8),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          width: 50,
                          height: 26,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color(0xff368F8B).withOpacity(.10)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(110, 40),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                backgroundColor: Color(0xff246A73)),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (builder) =>
                              //             PhysicalActivities()));
                            },
                            child: Text(
                              "Invite",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(110, 40),
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Chat",
                              style: TextStyle(
                                  color: Color(0xff246A73),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Position> getUserCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    await Geolocator.requestPermission()
        .then((value) async {
      print('getUserCurrentLocation:$value:${await Geolocator.getCurrentPosition()}');
    }).onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
}
