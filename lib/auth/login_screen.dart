import 'package:flutter/material.dart';
import 'package:join/auth/phone/continue_phone.dart';
import 'package:join/database/database_methods.dart';
import 'package:join/status/checkstatus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff160F29),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 100,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/news.png",
                  ),
                ),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40),
              child: Image.asset(
                "assets/small.png",
                width: 130,
                height: 60,
              ),
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.74,
                  margin: EdgeInsets.only(top: 65),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Log In",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xff246A73),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "ProximaNova")),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                            "Please select below option to continue.",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color(0xff736F7F),
                                fontSize: 16,
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () async {
                            await DatabaseMethods()
                                .signInWithGoogle()
                                .then((value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  CheckStatus()))
                                    });
                          },
                          child: Center(
                            child: Container(
                              height: 53,
                              width: 343,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 30,
                                      color: Color(0xff8377C6).withOpacity(.11))
                                ],
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.white],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/googl.png",
                                      height: 23,
                                      width: 23,
                                    ),
                                  ),
                                  Text(
                                    "Log In with Google",
                                    style: TextStyle(
                                        color: Color(0xff160F29),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: "ProximaNova"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Center(
                            child: Container(
                              height: 53,
                              width: 343,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 30,
                                      color: Color(0xff8377C6).withOpacity(.11))
                                ],
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.white],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/l.png",
                                      height: 23,
                                      width: 23,
                                    ),
                                  ),
                                  Text(
                                    "Log In with Facebook",
                                    style: TextStyle(
                                        color: Color(0xff160F29),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: "ProximaNova"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => ContinuePhone()));
                          },
                          child: Center(
                            child: Container(
                              height: 53,
                              width: 343,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 30,
                                      color: Color(0xff8377C6).withOpacity(.11))
                                ],
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.white],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/imgGgphone.png",
                                      height: 23,
                                      width: 23,
                                    ),
                                  ),
                                  Text(
                                    "Log In with Phone Number",
                                    style: TextStyle(
                                        color: Color(0xff160F29),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily: "ProximaNova"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff246A73).withOpacity(.10),
                          ),
                          margin: EdgeInsets.only(left: 10, top: 24, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "By registering or creating an account, you agree to our Terms of Use. Read our Privacy Policy to learn more about how we process your data.",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff246A73),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "ProximaNova"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]));
            }),
          ],
        ),
      ),
    );
  }
}
