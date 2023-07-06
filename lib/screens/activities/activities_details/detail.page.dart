import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../custom_navbar/custom_navbar.dart';

class DetailPage extends StatefulWidget {
  final endTime;
  final startTime;
  final address;
  final desc;
  final uuid;
  final createid;
  final date;
  final title;
  final image;
  final numbersofjoines;
  final statis;
  const DetailPage({
    super.key,
    required this.date,
    required this.image,
    required this.numbersofjoines,
    required this.title,
    required this.statis,
    required this.desc,
    required this.endTime,
    required this.createid,
    required this.uuid,
    required this.address,
    required this.startTime,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(19, 246, 246, 244),
        title: Text(
          widget.title,
          style: const TextStyle(
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Color(0xff160F29)),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.image.toString(),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            color: Colors.grey)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Title",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.statis,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/timer.png",
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.date,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.startTime,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("to"),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.endTime,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            color: Colors.grey)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.desc,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            color: Colors.grey)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.address,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        Image.asset("assets/ima.png")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            color: Colors.grey)
                      ]),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        var document = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Event",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(widget.image),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    widget.title,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              widget.createid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Container()
                                  : isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Color(0xff368F8B),
                                        ))
                                      : Center(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xff368F8B),
                                                  fixedSize:
                                                      const Size(321, 50)),
                                              onPressed: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                var uuid = Uuid().v4();
                                                await FirebaseFirestore.instance
                                                    .collection("joins")
                                                    .doc(uuid)
                                                    .set({
                                                  "previousuuid": widget.uuid,
                                                  "title": widget.title,
                                                  "status": "ongoing",
                                                  "number of joins": 0,
                                                  "startTime": widget.startTime,
                                                  "endTime": widget.endTime,
                                                  "date": widget.date,
                                                  "image": widget.image,
                                                  "desc": widget.desc,
                                                  "joinname": document['name'],
                                                  "creatorid": widget.createid,
                                                  "currentuuid": uuid,
                                                  "joinid": FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  "joinedRequest": "pending"
                                                }).then(
                                                  (value) => {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Event Join Request Send"),
                                                      ),
                                                    ),
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (builder) =>
                                                                MainScreen()))
                                                  },
                                                );
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              },
                                              child: const Text(
                                                "Join",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
