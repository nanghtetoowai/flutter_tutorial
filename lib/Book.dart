import 'package:flutter/material.dart';
import 'package:flutter_app/FirstScreen.dart';

class Book extends StatelessWidget {
  final String name;
  const Book (this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreenAccent,
        padding: EdgeInsets.all(10.0),
        width: 100.0,
        height: 100.0,
      child: Column(
        children: <Widget>[
          Icon(Icons.airplay),
          Text(name)
        ],
      )

    );
  }
}
