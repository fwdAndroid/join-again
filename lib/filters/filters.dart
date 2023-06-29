import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  bool _lights = false;
  int valueHolder = 20;
  int valueHolder1 = 14;
  int valueHolder2 = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text("Setting"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text(
              'Public Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              "Your Location is now public and you will be shown to other users on the map",
              style: TextStyle(fontSize: 12),
            ),
            value: _lights,
            onChanged: (bool value) {
              setState(() {
                _lights = value;
              });
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              "Anonymize your location 150m",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              "With the help of this slider you can anonymise your location on the map, i.e. other people do not seee your exact location, but the location offset by 150.0 meters",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Slider(
                  value: valueHolder.toDouble(),
                  min: 1,
                  max: 150,
                  divisions: 100,
                  activeColor: Color(0xff246A73),
                  inactiveColor: Colors.grey,
                  label: '${valueHolder.round()}',
                  onChanged: (double newValue) {
                    setState(() {
                      valueHolder = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}';
                  })),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Age 17-37",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Slider(
                  value: valueHolder.toDouble(),
                  min: 1,
                  max: 150,
                  divisions: 100,
                  activeColor: Color(0xff246A73),
                  inactiveColor: Colors.grey,
                  label: '${valueHolder.round()}',
                  onChanged: (double newValue) {
                    setState(() {
                      valueHolder = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}';
                  })),
          Divider(),
          SwitchListTile(
            title: const Text(
              'Show Users',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: _lights,
            onChanged: (bool value) {
              setState(() {
                _lights = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            title: const Text(
              'Show Events',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            value: _lights,
            onChanged: (bool value) {
              setState(() {
                _lights = value;
              });
            },
          ),
          Divider(),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Events in next 7 days",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Slider(
                  value: valueHolder.toDouble(),
                  min: 1,
                  max: 150,
                  divisions: 100,
                  activeColor: Color(0xff246A73),
                  inactiveColor: Colors.grey,
                  label: '${valueHolder.round()}',
                  onChanged: (double newValue) {
                    setState(() {
                      valueHolder = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}';
                  })),
        ],
      ),
    );
  }
}
