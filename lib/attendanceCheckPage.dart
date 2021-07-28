import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;

class AttendanceCheckPage extends StatefulWidget {
  @override
  _AttendanceCheckPageState createState() => new _AttendanceCheckPageState();
}

class _AttendanceCheckPageState extends State<AttendanceCheckPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Attendance Check'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Attendance').snapshots(),
            builder: (context, snapshot) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Usernames')
                      .snapshots(),
                  builder: (context, snapshot2) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    List<Widget> children = <Widget>[];
                    int iToUse = 0;
                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      if (snapshot.data.documents[i]['Title'] ==
                          globals.currentEventTitle) {
                        iToUse = i;
                      }
                    }
                    // for (int i = 2;
                    //     i < snapshot.data.documents[iToUse].length;
                    //     i++) {}
                    String fullName = "";
                    String username = "";
                    for (int i = 0; i < snapshot2.data.documents.length; i++) {
                      fullName = "";
                      username = snapshot2.data.documents[i]['Username'];
                      fullName += snapshot2.data.documents[i]['First Name'];
                      fullName += " ";
                      fullName += snapshot2.data.documents[i]['Last Name'];
                      (snapshot.data.documents[iToUse]['$username'])
                          ? children += <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$fullName'),
                                  Icon(Icons.check),
                                ],
                              )
                            ]
                          : children += <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$fullName'),
                                  Icon(Icons.cancel),
                                ],
                              )
                            ];
                      children += <Widget>[
                        SizedBox(
                          height: 25,
                        )
                      ];
                    }

                    // children += <Widget>[];
                    return InkWell(
                        onTap: () {},
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Center(
                              child: Column(
                                children: children,
                              ),
                            )));
                  });
            }));
  }
}
