import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:join/services/db_services.dart';

showCustomDialog(BuildContext context, dynamic data) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: const Text("Wait"),
        content: const Text("Are you Sure for Sending Request to This User"),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
          CupertinoActionSheetAction(
            onPressed: () async {
              await DatabaseServices.sendRequestToUserForChat(context: context, receiverId: data['uid']);
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}
