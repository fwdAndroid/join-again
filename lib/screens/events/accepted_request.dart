import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AcceptedRequest extends StatefulWidget {
  const AcceptedRequest({super.key});

  @override
  State<AcceptedRequest> createState() => _AcceptedRequestState();
}

class _AcceptedRequestState extends State<AcceptedRequest> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('joins')
      .where("joinedRequest", isEqualTo: "accepted")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            return data['joinid'] == FirebaseAuth.instance.currentUser!.uid ||
                    data['creatorid'] == FirebaseAuth.instance.currentUser!.uid
                ? Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
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
                                  const Text(
                                    "Event Title: ",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontSize: 16,
                                        color: Color(0xff160F29),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(data['title']),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Joiner Name:",
                                    style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        fontSize: 16,
                                        color: Color(0xff160F29),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(data['joinname']),
                                ],
                              ),
                            ],
                          ),
                          trailing: data['joinid'] ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? const Text("")
                              : TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("joins")
                                        .doc(document.id)
                                        .update({
                                      "joinedRequest": "denied",
                                      "number of joins":
                                          data["number of joins"] - 1
                                    }).then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "User Request is denied to join the event")));
                                    });
                                  },
                                  child: const Text(
                                    "Denied",
                                    style: TextStyle(color: Colors.red),
                                  ))),
                    ),
                  )
                : Container();
          }).toList(),
        );
      },
    );
  }
}
