import 'package:flutter/material.dart';
import 'package:join/widgets/custom_dialog.dart';

class UserCustomCard extends StatelessWidget {
  final dynamic data;
  const UserCustomCard({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(data['name'][0].toString().toUpperCase()),
          ),
          title: Text(data['name']),
          subtitle: Text(
            data['email'],
            style: const TextStyle(fontSize: 10),
          ),
          trailing: InkWell(
            onTap: () {
              showCustomDialog(context, data);
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  "Send Request",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
