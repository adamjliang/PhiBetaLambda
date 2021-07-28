import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:prof_frat_app/addHomework.dart';
import './globals.dart' as globals;
import './checkInUser.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => new _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Choose an Event'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         new MaterialPageRoute(
          //             builder: (BuildContext context) =>
          //                 new AddAttendanceEventPage()),
          //       );
          //     },
          //   )
          // ],
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
                children += <Widget>[SizedBox(height: 25)];
                children += <Widget>[
                  DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(-0.5, 0),
                          radius: 0.15,
                          colors: <Color>[
                            Color(0xFF000000),
                            Color(0xFFD3D3D3),
                          ],
                          stops: <double>[0.9, 1.0],
                        ),
                      ),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      globals.currentCheckInEventTitle =
                                          snapshot.data.documents[i]['Title'];

                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new CheckInUserPage()),
                                      );
                                    },
                                    child: Center(
                                        child: Text(
                                      snapshot.data.documents[i]['Title'],
                                      style: TextStyle(
                                          fontSize: 30, color: globals.pblblue),
                                    )))),
                          ]))),
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
