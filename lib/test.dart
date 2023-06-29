import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Aplle extends StatelessWidget {
  TextEditingController _addressController = TextEditingController();

  void _convertAddressToCoordinates() async {
    String address = _addressController.text;
    LatLng coordinates = await getCoordinates(address);
    if (coordinates != null) {
      print('Latitude: ${coordinates.latitude}');
      print('Longitude: ${coordinates.longitude}');
      // Use the coordinates as needed in your app
    }
  }

  Future<LatLng> getCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return LatLng(location.latitude, location.longitude);
      }
    } on Exception catch (e) {
      print('Error: $e');
    }
    return getCoordinates(address);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Address Converter'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Enter address',
              ),
            ),
            ElevatedButton(
              onPressed: _convertAddressToCoordinates,
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
