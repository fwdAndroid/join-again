import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';
import 'package:join/activity/geo_service.dart';
import 'package:join/database/storage_methods.dart';
import 'package:join/main/main_screen.dart';

class MapScreenActivity extends StatefulWidget {
  final starttime;
  final endtime;
  final title;
  final desc;
  final cate;
  final day;
  final image;
  const MapScreenActivity(
      {super.key,
      required this.cate,
      required this.day,
      required this.title,
      required this.desc,
      required this.endtime,
      required this.starttime,
      required this.image});

  @override
  State<MapScreenActivity> createState() => _MapScreenActivityState();
}

class _MapScreenActivityState extends State<MapScreenActivity> {
  TextEditingController _locationController = TextEditingController();
  String googleApikey = "AIzaSyBffT8plN_Vdcd308KgmzIfGVQN6q-CkAo";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  bool _isLoading = false;
  bool loading = false;
  List latlong = [];
  String location = 'Please move map to A specific location.';
  var uuid = Uuid().v4();
  @override
  void initState() {
    getLatLong();
    _locationController.text = "Select Activity Location From Map";
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng startLocation = _isLoading
        ? const LatLng(25.276987, 55.296249)
        : LatLng(latlong[0], latlong[1]);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 6,
        title: Text(
          "Set Location",
          style: TextStyle(
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Color(0xff160F29)),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Container(
              height: 800,
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
                      List<Placemark> addresses =
                          await placemarkFromCoordinates(
                              cameraPosition!.target.latitude,
                              cameraPosition!.target.longitude);

                      var first = addresses.first;
                      print("${first.name} : ${first..administrativeArea}");

                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
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
                  Center(
                    //picker image on google map
                    child: Image.asset(
                      "assets/user_loc.png",
                      width: 30,
                      height: 30,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 60, left: 20, right: 20),
                      height: 174,
                      width: 343,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.1), //(x,y)
                              blurRadius: 0.5,
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 10),
                            child: Text(
                              "Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff736F7F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Color(0xffE5E5EA),
                                  )),
                              margin:
                                  EdgeInsets.only(left: 15, top: 10, right: 10),
                              child: TextField(
                                onTap: () async {
                                  var place = await PlacesAutocomplete.show(
                                      context: context,
                                      apiKey: googleApikey,
                                      mode: Mode.overlay,
                                      types: [],
                                      strictbounds: false,
                                      // components: [
                                      //   Component(Component.country, 'ae')
                                      // ],
                                      //google_map_webservice package
                                      onError: (err) {
                                        print(err);
                                      });

                                  if (place != null) {
                                    setState(() {
                                      location = place.description.toString();
                                      _locationController.text = location;
                                    });
                                    final plist = GoogleMapsPlaces(
                                      apiKey: googleApikey,
                                      apiHeaders:
                                          await GoogleApiHeaders().getHeaders(),
                                      //from google_api_headers package
                                    );
                                    String placeid = place.placeId ?? "0";
                                    final detail = await plist
                                        .getDetailsByPlaceId(placeid);
                                    final geometry = detail.result.geometry!;
                                    final lat = geometry.location.lat;
                                    final lang = geometry.location.lng;
                                    var newlatlang = LatLng(lat, lang);
                                    mapController?.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: newlatlang, zoom: 17)));
                                  }
                                },
                                controller: _locationController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            color: Color(0xffE5E5EA))),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Color(0xffE5E5EA),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffE5E5EA),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.pin_drop_rounded,
                                      color: Colors.black,
                                    ),
                                    border: InputBorder.none,
                                    hintText:
                                        "52 Rue Des Fleurs 33500 Libourne"),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )),

                          // Note
                          // There is a Problem in longitude and latitude it using default user location values not
                          //the values we selected by the navigate the map cursoor
                          Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            child: Center(
                                child: loading
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            fixedSize: Size(343, 48),
                                            backgroundColor: Color(0xff246A73)),
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });

                                          Position position = await Geolocator
                                              .getCurrentPosition(
                                                  desiredAccuracy:
                                                      LocationAccuracy.best);

                                          String photoURL =
                                              await StorageMethods()
                                                  .uploadImageToStorage(
                                                      'UserPics',
                                                      widget.image!,
                                                      true);

                                          FirebaseFirestore.instance
                                              .collection("activity")
                                              .doc(uuid)
                                              .set({
                                            "title": widget.title,
                                            "uuid": uuid,
                                            "description": widget.desc,
                                            "address": _locationController.text,
                                            "category": widget.cate,
                                            "photo": photoURL,
                                            "latitude":
                                                position.latitude, //Issue
                                            "longitude":
                                                position.longitude, // Issue
                                            "date": widget.day,
                                            "uid": FirebaseAuth
                                                .instance.currentUser!.uid,
                                            "startTime": widget.starttime,
                                            "endTime": widget.endtime,
                                            "activity": widget.cate,
                                            "activitystatus": "ongoing",
                                            "numberofjoiners": 0,
                                          });

                                          setState(() {
                                            loading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Activity Created Successfully")));
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      MainScreen()));
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // if (_locationController.text.isEmpty) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("All Fields are required")));
  //   } else {

  //   }

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
}
