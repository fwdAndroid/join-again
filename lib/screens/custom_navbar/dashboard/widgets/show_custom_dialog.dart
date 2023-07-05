import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SizedBox(
        width: 500,
        height: 267,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            insetPadding: const EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(5),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(
                            Icons.close,
                            color: Color(0xffFF1919),
                            size: 9,
                          ),
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffFF1919).withOpacity(.20)),
                        ),
                      ),
                    ],
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/errors.png"),
                    ),
                    title: Text(
                      "Paddy O'Furniture",
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "Lorem Ipsum",
                      style: TextStyle(color: Color(0xff736F7F), fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  //todo make a reusable button for House party and call it only
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            "House Party",
                            style: TextStyle(color: Color(0xff246A73), fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: 50,
                        height: 26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xff368F8B).withOpacity(.10)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            "House Party",
                            style: TextStyle(color: Color(0xff246A73), fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: 50,
                        height: 26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xff368F8B).withOpacity(.10)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            "House Party",
                            style: TextStyle(color: Color(0xff246A73), fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: 50,
                        height: 26,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Color(0xff368F8B).withOpacity(.10)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //todo: use only one button instead of hardcoding and call parameters of button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(110, 40),
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              backgroundColor: Color(0xff246A73)),
                          onPressed: () {},
                          child: Text(
                            "Invite",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(110, 40),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Chat",
                            style: TextStyle(color: Color(0xff246A73), fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
