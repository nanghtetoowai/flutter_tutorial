import 'package:flutter/material.dart';




class Book extends StatelessWidget {
  final String name;
  const Book (this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: 100.0,
        height: 80.0,
        decoration: new BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(10.0),
                topRight: const  Radius.circular(10.0),
                bottomLeft: const  Radius.circular(10.0),
                bottomRight: const  Radius.circular(10.0))

    ),
      child: Column(
        children: <Widget>[
          Icon(Icons.airplay),
          Text(name)
        ],
      )

    );
  }
}
