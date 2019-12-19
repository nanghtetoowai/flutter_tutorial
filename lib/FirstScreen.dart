import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Book.dart';
import 'package:flutter_app/Dialog.dart';
import 'package:flutter_app/SecondScreen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body:Column(
        children: <Widget>[
          Container(
      child:Padding(
          padding: EdgeInsets.all(10.0),

    )
    ),
      Container(
        child: RaisedButton(
          child: Text('Next Screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
            // Navigate to second route when tapped.
          },
        ),
      ),
        MyDialog("ssss"),
         SizedBox(height: 20.0),
         Image(
           image: AssetImage('assets/beelogo.png'),


         )
        ],
      )
    );
  }
}