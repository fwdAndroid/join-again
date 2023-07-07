import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/services/db_services.dart';

class CustomRequestCardForReceivedRequest extends StatelessWidget {
  final dynamic userSnap;
  final dynamic createdData;
  final dynamic data;
  const CustomRequestCardForReceivedRequest(
      {Key? key, this.userSnap, this.createdData, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.1, 0.1))]),
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
              Text(createdData),
              SizedBox(
                width: 130,
                child: Row(
                  children: [
                    SuggestionButton(
                        onPressed: () async {
                          await DatabaseServices.cancelRequest(docId: data);
                        },
                        title: "Cancel",
                        borderColor: Colors.red),
                    SuggestionButton(
                        onPressed: () async {
                          await DatabaseServices.acceptRequest(
                            docId: data['requestId'],
                            myId: FirebaseAuth.instance.currentUser!.uid,
                            friendId: data['senderId'],
                          );
                        },
                        title: "Accept",
                        borderColor: Colors.green),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//todo please shift this button to buttons.dart file in widgets folder
class SuggestionButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? borderColor;
  const SuggestionButton(
      {Key? key, this.title, this.onPressed, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(2),
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(08),
          border: Border.all(color: borderColor!),
        ),
        child: Center(
          child: Text(title!),
        ),
      ),
    );
  }
}
