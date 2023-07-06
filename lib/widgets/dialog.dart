import 'package:flutter/material.dart';

class Dialogs extends StatelessWidget {
  final String? title;
  final List<Widget>? fl;

  const Dialogs({super.key, this.title, this.fl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("$title"),
            ],
          ),
        ),
        actions: fl);
  }
}
