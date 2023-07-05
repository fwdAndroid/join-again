import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  All({
    super.key,
  });

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('activity').snapshots();
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
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 0.5)]),
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (builder) => DetailPage(date: date, image: image, title: title, statis: statis, desc: desc, endTime: endTime, createid: createid, uuid: uuid, location: location, address: address, startTime: startTime)))
                        },
                        child: Container(
                          height: 100,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  data['photo'],
                                  height: 100,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    "assets/whiteshare.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          data['title'],
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff160F29), fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          data['description'],
                          style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff160F29).withOpacity(.6), fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/timer.png",
                              width: 14,
                              height: 15,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              data['date'],
                              style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff160F29).withOpacity(.6), fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data['startTime'],
                              style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff160F29).withOpacity(.6), fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "to",
                              style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff160F29).withOpacity(.6), fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              data['endTime'],
                              style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff160F29).withOpacity(.6), fontSize: 12),
                            ),
                            Spacer(),
                            Container(
                              width: 64,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color(0xff246A73).withOpacity(.10),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text(
                                    data['numberofjoiners'].toString() + '  Going',
                                    style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xff246A73), fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          }).toList(),
        );
      },
    );
  }
}
