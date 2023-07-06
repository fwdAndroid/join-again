import 'package:flutter/material.dart';

class CustomRequestCard extends StatelessWidget {
  final dynamic userSnap;
  final dynamic date;
  const CustomRequestCard({Key? key, this.userSnap, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 05),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(userSnap['name'][0].toString().toUpperCase()),
          ),
          title: Text(userSnap['name']),
          subtitle: Text(userSnap['phone']),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date),
              const Text("pending..."),
            ],
          ),
        ),
      ),
    );
  }
}
