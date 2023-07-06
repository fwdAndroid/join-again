import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  final List userList;
  const FriendsScreen({Key? key, required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My FriendList"),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(userList[index]).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Text(userData['name'][0].toString().toUpperCase()),
                    ),
                    title: Text(userData['name']),
                    subtitle: Text(userData['phone']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
