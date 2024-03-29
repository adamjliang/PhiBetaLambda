import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prof_frat_app/votingsetup.dart';
//import 'package:prof_frat_app/addHomework.dart';
import './globals.dart' as globals;

class MutatorsPage extends StatefulWidget {
  @override
  _MutatorsPageState createState() => new _MutatorsPageState();
}

class _MutatorsPageState extends State<MutatorsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Mutators'),
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
                FirebaseFirestore.instance.collection('Homework').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text('Voting'),
                          Align(
                            child: Switch(
                              value: globals.isVoteSwitched,
                              onChanged: (value) {
                                setState(() {
                                  globals.isVoteSwitched = value;
                                });
                                if (globals.isVoteSwitched == true) {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new VotingSetupPage()),
                                  );
                                } else {
                                  //turning it off
                                  //print(globals.gFriendsList);
                                  globals.gFriendsList = [null];
                                  //print(globals.gFriendsList);
                                }
                              },
                              activeTrackColor: Colors.lightGreenAccent,
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text('Change'),
                          Switch(
                            value: globals.isChangeSwitched,
                            onChanged: (value) {
                              setState(() {
                                globals.isChangeSwitched = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
