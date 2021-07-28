import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './addAttendanceEvent.dart';
import './attendanceCheckPage.dart';
//import 'package:prof_frat_app/addHomework.dart';
import './globals.dart' as globals;

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => new _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Attendance List'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new AddAttendanceEventPage()),
                );
              },
            )
          ],
          // actions: (globals.level == 100 || globals.level == 1000)
          //     ? <Widget>[
          //         IconButton(
          //           icon: Icon(Icons.add),
          //           onPressed: () {
          //             Navigator.push(
          //               context,
          //               new MaterialPageRoute(
          //                   builder: (BuildContext context) =>
          //                       new AddHomeworkPage()),
          //             ) /*.then((value) {
          //               setState(() {
          //                 final dateTime = DateTime.now();
          //                 _calendarController.setSelectedDay(
          //                   DateTime(
          //                       dateTime.year, dateTime.month, dateTime.day),
          //                   runCallback: true,
          //                 );
          //               });
          //             });*/
          //                 ;
          //           },
          //         )
          //       ]
          //     : null,
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Attendance').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              List<Widget> children = <Widget>[];
              int finish = snapshot.data.documents.length;
              for (int i = 0; i < finish; i++) {
                children += <Widget>[
                  Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        InkWell(
                            onTap: () {
                              globals.currentEventTitle =
                                  snapshot.data.documents[i]['Title'];
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new AttendanceCheckPage()),
                              );
                            },
                            child: Text(snapshot.data.documents[i]['Title'])),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("Attendance")
                                    .doc(snapshot.data.documents[i]["Title"]
                                        .toString())
                                    .delete();
                              });
                            })
                      ]))
                ];
              }
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      children: children,
                    ),
                  ));
            }));
  }
}
