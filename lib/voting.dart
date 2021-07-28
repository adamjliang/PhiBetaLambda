import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => new _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Voting'),
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
            stream: FirebaseFirestore.instance.collection('Voting').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              List<Widget> children = <Widget>[];
              List<Widget> emptiness = <Widget>[];
              for (int i = 0; i < globals.gFriendsList.length; i++) {
                String candidateName = globals.gFriendsList[i];
                children += <Widget>[
                  SwitchListTile(
                      title: Text('$candidateName'),
                      value: (i == 0)
                          ? globals.firstSwitch
                          : (i == 1)
                              ? globals.secondSwitch
                              : (i == 2)
                                  ? globals.thirdSwitch
                                  : (i == 3)
                                      ? globals.fourthSwitch
                                      : (i == 4)
                                          ? globals.fifthSwitch
                                          : (i == 5)
                                              ? globals.sixthSwitch
                                              : (i == 6)
                                                  ? globals.seventhSwitch
                                                  : (i == 7)
                                                      ? globals.eighthSwitch
                                                      : (i == 8)
                                                          ? globals.ninthSwitch
                                                          : globals.tenthSwitch,
                      onChanged: (bool value) {
                        setState(() => (i == 0)
                            ? globals.firstSwitch = value
                            : (i == 1)
                                ? globals.secondSwitch = value
                                : (i == 2)
                                    ? globals.thirdSwitch = value
                                    : (i == 3)
                                        ? globals.fourthSwitch = value
                                        : (i == 4)
                                            ? globals.fifthSwitch = value
                                            : (i == 5)
                                                ? globals.sixthSwitch = value
                                                : (i == 6)
                                                    ? globals.seventhSwitch =
                                                        value
                                                    : (i == 7)
                                                        ? globals.eighthSwitch =
                                                            value
                                                        : (i == 8)
                                                            ? globals
                                                                    .ninthSwitch =
                                                                value
                                                            : globals
                                                                    .tenthSwitch =
                                                                value);
                      }),
                ];
              }

              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      children: (globals.gFriendsList.length == 0)
                          ? emptiness
                          : (globals.gFriendsList[0] != null)
                              ? children
                              : emptiness,
                    ),
                  ));
            }));
  }
}
