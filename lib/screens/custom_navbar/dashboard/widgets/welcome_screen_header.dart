import 'package:flutter/material.dart';
import 'package:join/screens/activities/activities_panel/relax.dart';
import 'package:join/screens/activities/activities_panel/sip_together.dart';

import '../../../../utils/lists.dart';
import '../../../activities/activities_panel/create.dart';
import '../../../activities/activities_panel/intectualactivities.dart';
import '../../../activities/activities_panel/physical_activities.dart';

class WelcomeScreenHorizontalHeader extends StatelessWidget {
  const WelcomeScreenHorizontalHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 110),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: welcomeScreenHeaderImages.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const PhysicalActivities()));
              } else if (index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const IntelacutualActivities()));
              } else if (index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const SipTogether()));
              } else if (index == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const Create()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => const Relaxation()));
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Image.asset(welcomeScreenHeaderImages[index], width: 50, height: 50, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Text(
                    welcomeScreenHeaderTitles[index],
                    style: TextStyle(
                        color: const Color(0xff160F29).withOpacity(.8),
                        fontSize: 10,
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
