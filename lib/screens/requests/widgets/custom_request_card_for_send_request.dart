import 'package:flutter/material.dart';

class CustomRequestCard extends StatelessWidget {
  final dynamic userSnap;
  final dynamic date;
  const CustomRequestCard({Key? key, this.userSnap, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.1, 0.1))]),
      // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //  change this with figma icon mail
              Icon(
                Icons.mail,
                color: const Color(0xffFF7E87),
              ),
              const Text("Pending"),
            ],
          ),
        ),
      ),
    );
  }
}
