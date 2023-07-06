import 'package:flutter/material.dart';
import 'package:join/screens/requests/widgets/receive_request.dart';
import 'package:join/screens/requests/widgets/sending_requests.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            // The style of the input field
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search',
              border: InputBorder.none,
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ), // Edit icon
              // The style of the hint text
              hintStyle: TextStyle(
                  color: const Color(0xff736F7F).withOpacity(.34),
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
            controller: searchController, // The controller of the input box
          ),

          automaticallyImplyLeading: false,
          // title: const Text("All Requests"),
          bottom: const TabBar(
            tabs: [
              Text("Send Requests"),
              Text("Receive Requests"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SendingRequest(),
            ReceivedRequest(),
          ],
        ),
      ),
    );
  }
}
