import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({super.key});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 246),
      appBar: AppBar(
        title: Text(
          "Notifications",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "ProximaNova",
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Color(0xff160F29)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, top: 5),
              child: Text(
                "Today",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff160F29)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 330,
                        child: Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset(
                                "assets/main.png",
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                "Fay Daway join your activity",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "ProximaNova",
                                ),
                              ),
                              subtitle: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. odio vel et massa quis ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "ProximaNova",
                                ),
                              ),
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
