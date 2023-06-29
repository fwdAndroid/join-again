import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:join/chat_views/views/ChatScreen.dart';
import 'package:join/chat_views/views/globals.dart';
import 'package:join/chat_views/views/models/UserModel.dart';
import 'package:join/main/dashboard_pages/create_activity.dart';
import 'package:join/main/dashboard_pages/my_profile.dart';
import 'package:join/main/dashboard_pages/welcome_page.dart';
import 'package:join/main/dashboard_pages/your_calender.dart';
import 'package:join/main/message_screen.dart';

class MainScreen extends StatefulWidget {
  // MainScreen ({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    const WelComePage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const WelComePage(); // Our first view in viewport

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID=FirebaseAuth.instance.currentUser!.uid??'';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        backgroundColor: Color(0xffFF7E87),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => CreateActivity()));
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Welcome
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        const WelComePage(); // if user taps on this dashboard tab will be active
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 0
                          ? 'assets/locationcolor.png'
                          : 'assets/location.png',
                      height: 20,
                    )
                  ],
                ),
              ),

              //Calender
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        YourCalender(); // if user taps on this dashboard tab will be active

                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 1
                          ? 'assets/colors.png'
                          : 'assets/calender.png',
                      height: 20,
                    )
                  ],
                ),
              ),
              //Chat
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = MessageScreen();
//                    currentScreen = ChatScreen(UserModel(uid: 'a3IwdwOqpTMD2mc1LyQCwIWuUTq1',name: 'testing',email: 'test@gmail.com',phoneNumber: '+923078508248',photoUrl: 'https://firebasestorage.googleapis.com/v0/b/join-a0ce2.appspot.com/o/ProfilePics%2Fa3IwdwOqpTMD2mc1LyQCwIWuUTq1?alt=media&token=9f01fd6a-d3af-4630-861a-ca87eb79e942'));
                    // if user taps on this dashboard tab will be active
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 2 ? 'assets/chats.png' : 'assets/chat1.png',
                      height: 20,
                    )
                  ],
                ),
              ),
              //Profile
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = MyProfile();
                    // if user taps on this dashboard tab will be active
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 3
                          ? 'assets/profilecolor.png'
                          : 'assets/person.png',
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
