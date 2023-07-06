import 'package:flutter/material.dart';
import 'package:join/widgets/custom_dialog.dart';

class UserCustomCard extends StatelessWidget {
  final dynamic data;
  const UserCustomCard({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.1, 0.1))]),
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
                color: Color(0xff246A73),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  "Send Request",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
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
