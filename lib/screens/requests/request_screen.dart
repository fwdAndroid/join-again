import 'package:flutter/material.dart';
import 'package:join/screens/requests/widgets/receive_request.dart';
import 'package:join/screens/requests/widgets/sending_requests.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Requests"),
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
