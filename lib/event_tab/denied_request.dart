import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DeniedRequest extends StatefulWidget {
  const DeniedRequest({super.key});

  @override
  State<DeniedRequest> createState() => _DeniedRequestState();
}

class _DeniedRequestState extends State<DeniedRequest> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('joins')
      .where("joinedRequest", isEqualTo: "denied")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            return Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 0.5)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Event Title: ",
                              style: TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontSize: 16,
                                  color: Color(0xff160F29),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(data['title']),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Joiner Name:",
                              style: TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontSize: 16,
                                  color: Color(0xff160F29),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(data['joinname']),
                          ],
                        ),
                      ],
                    ),
                    trailing: data['joinid'] ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? Text("")
                        : TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("joins")
                                  .doc(document.id)
                                  .update({
                                "joinedRequest": "accepted",
                                "number of joins": data["number of joins"] - 1
                              }).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "User Request is accepted to join the event")));
                              });
                            },
                            child: Text(
                              "Accept",
                              style: TextStyle(color: Colors.green),
                            ))),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
