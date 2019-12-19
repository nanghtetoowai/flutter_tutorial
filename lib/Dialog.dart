import 'package:flutter/material.dart';
import 'package:flutter_app/Book.dart';

class MyDialog extends StatefulWidget {
  final String text;
  const MyDialog(this.text);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  void _showcontent() {
    showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                 Text("This is Dialog"),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
//          child: RaisedButton(onPressed: _showcontent, color: Colors.white60,
              child:Column(
                children: <Widget>[
                RaisedButton(
                  onPressed: _showcontent,color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text("Dialog 1"),
                      Icon(Icons.airplay)
                    ],
                  )
                ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: _showcontent,color: Colors.lightGreenAccent,
                    padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Text("Dialog 2"),
                          Icon(Icons.android)
                        ],
                      )                  ),
                  SizedBox(height: 10.0),

                  RaisedButton(
                    onPressed: _showcontent,color: Colors.deepPurpleAccent,
                    padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Text("Dialog 3"),
                          Icon(Icons.brush)
                        ],
                      )                  )

                ],
              )
//            ),

        );
  }
}