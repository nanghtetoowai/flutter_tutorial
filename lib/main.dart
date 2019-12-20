//import 'package:flutter/material.dart';
//import 'FirstScreen.dart';
//import 'SecondScreen.dart';
//
//
//void main(){
//
//  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    title: 'Named Routes Demo',
//    // Start the app with the "/" named route. In this case, the app starts
//    // on the FirstScreen widget.
//    initialRoute: '/',
//    routes: {
//      // When navigating to the "/" route, build the FirstScreen widget.
//      '/': (context) => FirstScreen(),
//      // When navigating to the "/second" route, build the SecondScreen widget.
//      '/second': (context) => SecondScreen(),
//    },
//  ));
//}
//
////import 'dart:async';
////import 'dart:convert';
////
////import 'package:flutter/material.dart';
////import 'package:http/http.dart' as http;
////
////Future<Post> fetchPost() async {
////  final response =
////  await http.get('https://jsonplaceholder.typicode.com/posts/1');
////
////  if (response.statusCode == 200) {
////    // If the call to the server was successful, parse the JSON.
////    return Post.fromJson(json.decode(response.body));
////  } else {
////    // If that call was not successful, throw an error.
////    throw Exception('Failed to load post');
////  }
////}
////
////class Post {
////  final int userId;
////  final int id;
////  final String title;
////  final String body;
////
////  Post({this.userId, this.id, this.title, this.body});
////
////  factory Post.fromJson(Map<String, dynamic> json) {
////    return Post(
////      userId: json['userId'],
////      id: json['id'],
////      title: json['title'],
////      body: json['body'],
////    );
////  }
////}
////
////void main() => runApp(MyApp());
////
////class MyApp extends StatefulWidget {
////  MyApp({Key key}) : super(key: key);
////
////  @override
////  _MyAppState createState() => _MyAppState();
////}
////
////class _MyAppState extends State<MyApp> {
////  Future<Post> post;
////
////  @override
////  void initState() {
////    super.initState();
////    post = fetchPost();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return MaterialApp(
////
////      title: 'Fetch Data Example',
////      theme: ThemeData(
////        primarySwatch: Colors.blue,
////      ),
////      home: Scaffold(
////        appBar: AppBar(
////          title: Text('Fetch Data Example'),
////        ),
////        body: Center(
////          child: FutureBuilder<Post>(
////            future: post,
////            builder: (context, snapshot) {
////              if (snapshot.hasData) {
////                return Text(snapshot.data.title);
////              } else if (snapshot.hasError) {
////                return Text("${snapshot.error}");
////              }
////
////              // By default, show a loading spinner.
////              return CircularProgressIndicator();
////            },
////          ),
////        ),
////      ),
////    );
////  }
////}
////
//
//
//
import 'package:flutter/material.dart';
import 'package:flutter_app/Student.dart';
import 'package:flutter_app/dbHelper.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>> students;
  String _studentName;
  bool isUpdate = false;
  int studentIdForUpdate;
  DBHelper dbHelper;
  final _studentNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshStudentList();
  }

  refreshStudentList() {
    setState(() {
      students = dbHelper.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD in Flutter'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Student Name';
                      }
                      if (value.trim() == "")
                        return "Only Space is Not Valid!!!";
                      return null;
                    },
                    onSaved: (value) {
                      _studentName = value;
                    },
                    controller: _studentNameController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.pink,
                                width: 2,
                                style: BorderStyle.solid)),
                        // hintText: "Student Name",
                        labelText: "Student Name",
                        icon: Icon(
                          Icons.business_center,
                          color: Colors.pink,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.amber,
                child: Text(
                  (isUpdate ? 'UPDATE' : 'ADD'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper
                          .update(Student(studentIdForUpdate, _studentName))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper.add(Student(null, _studentName));
                    }
                  }
                  _studentNameController.text = '';
                  refreshStudentList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.pink,
                child: Text(
                  (isUpdate ? 'CANCEL UPDATE' : 'CLEAR'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _studentNameController.text = '';
                  setState(() {
                    isUpdate = false;
                    studentIdForUpdate = null;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: students
              .map(
                (student) => DataRow(
              cells: [
                DataCell(
                  Text(student.name),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentNameController.text = student.name;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(student.id);
                      refreshStudentList();
                    },
                  ),
                )
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}