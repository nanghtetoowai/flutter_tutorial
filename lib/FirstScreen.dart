import 'package:flutter/material.dart';
import 'package:flutter_app/Book.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body:Container(
        child:Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Book("Product 1"),
              SizedBox(height:8.0),
              Book("Product 2"),
              SizedBox(height:8.0),
              Book("Product 3")
            ],
          ),
        )
      )
    );
  }
}