import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;

class AddAttendanceEventPage extends StatefulWidget {
  @override
  _AddAttendanceEventPageState createState() =>
      new _AddAttendanceEventPageState();
}

class _AddAttendanceEventPageState extends State<AddAttendanceEventPage> {
  var _titleController = TextEditingController();
  var _codeController = TextEditingController();
  // var _locationController = TextEditingController();
  // var _dresscodeController = TextEditingController();
  String titleValue = "";
  String codeValue = "";
  // String locationValue = "";
  // String dresscodeValue = "";

  // DateTime _today = DateTime.now();
  // bool _startTimeOpen = true;
  // bool _endTimeOpen = true;
  bool successfullyCreatedNewEvent = false;
  bool duplicateEvent = false;
  bool _validateTitle = false;
  bool _validateCode = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Add Event'),
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
                    return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          SizedBox(height: 50),
                          (successfullyCreatedNewEvent)
                              ? Text(
                                  'Successfully created new attendance event!',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.green))
                              : Container(),
                          (successfullyCreatedNewEvent)
                              ? SizedBox(height: 50)
                              : Container(),
                          (duplicateEvent)
                              ? Text(
                                  'Duplicate Event! Please create a different event.',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red))
                              : Container(),
                          (duplicateEvent) ? SizedBox(height: 50) : Container(),
                          // (lowClearanceError)?Text('Error: You do not have permission to add to that calendar', style: TextStyle(fontSize: 18, color: Colors.red)):Container(),
                          // (lowClearanceError)?SizedBox(height: 50):Container(),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 275,
                                child: TextFormField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      hintText: 'Name of Event',
                                      labelText: 'Name of Event*',
                                      errorText: _validateTitle
                                          ? 'Value Cannot Be Empty'
                                          : null,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        //borderRadius: new BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        //borderRadius: new BorderRadius.circular(25.7),
                                      )),
                                  onFieldSubmitted: (String value) {
                                    titleValue = value;
                                  },
                                  onChanged: (String value) {
                                    titleValue = value;
                                  },
                                )),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [SizedBox(height: 25)]),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 275,
                                child: TextFormField(
                                  controller: _codeController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      hintText: 'Sign-in Code',
                                      labelText: 'Sign-in Code*',
                                      errorText: _validateCode
                                          ? 'Value Cannot Be Empty'
                                          : null,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        //borderRadius: new BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        //borderRadius: new BorderRadius.circular(25.7),
                                      )),
                                  onFieldSubmitted: (String value) {
                                    codeValue = value;
                                  },
                                  onChanged: (String value) {
                                    codeValue = value;
                                  },
                                )),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [SizedBox(height: 25)]),

                          Row(children: [SizedBox(height: 25)]),
                          InkWell(
                            onTap: () {
                              if (titleValue == "") {
                                setState(() {
                                  _validateTitle = true;
                                });
                              } else {
                                _validateTitle = false;
                              }
                              if (codeValue == "") {
                                setState(() {
                                  _validateCode = true;
                                });
                              } else {
                                _validateCode = false;
                              }

                              int thruEvents = snapshot.data.documents.length;

                              for (int i = 0; i < thruEvents; i++) {
                                if (titleValue ==
                                    snapshot.data.documents[i]['Title']) {
                                  _validateTitle = true;
                                  setState(() {
                                    duplicateEvent = true;
                                    titleValue = "";
                                    codeValue = "";

                                    _titleController.clear();
                                    _codeController.clear();
                                  });
                                  i = thruEvents;
                                }
                              }
                              if (!_validateTitle && !_validateCode) {
                                //equiv of allValid

                                setState(() {
                                  successfullyCreatedNewEvent = true;
                                  duplicateEvent = false;
                                  //printedDate += _chosenStartDate.toString().substring(startIndex)

                                  FirebaseFirestore.instance
                                      .collection("Attendance")
                                      .doc('$titleValue')
                                      .set(
                                    {
                                      'Title': '$titleValue',
                                      'Code': '$codeValue',
                                    },
                                  );

                                  int finish = snapshot2.data.documents.length;
                                  for (int i = 0; i < finish; i++) {
                                    FirebaseFirestore.instance
                                        .collection('Attendance')
                                        .doc('$titleValue')
                                        .set({
                                      '${snapshot2.data.documents[i]['Username']}':
                                          false,
                                    }, SetOptions(merge: true));
                                  }

                                  titleValue = "";
                                  codeValue = "";

                                  _titleController.clear();
                                  _codeController.clear();
                                });
                              } else {
                                setState(() {
                                  successfullyCreatedNewEvent = false;
                                });
                              }
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  color: globals.pblblue,
                                  width: 175,
                                  height: 50,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Add Event',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                        )),
                                  )),
                            ),
                          ),
                        ] //children
                            ));
                  });
            }));
  }
}
