import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;

class AddEventsPage extends StatefulWidget {
  @override
  _AddEventsPageState createState() => new _AddEventsPageState();
}

class _AddEventsPageState extends State<AddEventsPage> {
  var _titleController = TextEditingController();
  var _locationController = TextEditingController();
  var _dresscodeController = TextEditingController();
  String titleValue = "";
  String locationValue = "";
  String dresscodeValue = "";
  String hintText = 'Personal';
  DateTime _today = DateTime.now();
  bool _startTimeOpen = true;
  bool _endTimeOpen = true;
  bool successfullyCreatedNewEvent = false;
  bool lowClearanceError = false;
  DateTime _chosenStartDate = DateTime.now();
  DateTime _chosenEndDate = DateTime.now();
  bool _validateTitle = false;

  int calChoice = 0;

  String _changeToReadableDate(DateTime x) {
    String returnString = "";

    switch (x.month) {
      case 1:
        {
          returnString += "January";
        }
        break;
      case 2:
        {
          returnString += "February";
        }
        break;
      case 3:
        {
          returnString += "March";
        }
        break;
      case 4:
        {
          returnString += "April";
        }
        break;
      case 5:
        {
          returnString += "May";
        }
        break;
      case 6:
        {
          returnString += "June";
        }
        break;
      case 7:
        {
          returnString += "July";
        }
        break;
      case 8:
        {
          returnString += "August";
        }
        break;
      case 9:
        {
          returnString += "September";
        }
        break;
      case 10:
        {
          returnString += "October";
        }
        break;
      case 11:
        {
          returnString += "November";
        }
        break;
      case 12:
        {
          returnString += "December";
        }
        break;
    }

    returnString += " ";
    returnString += x.day.toString();
    returnString += ", ";
    returnString += x.year.toString();
    returnString += ", ";

    if (x.hour > 12) {
      returnString += (x.hour - 12).toString();
      returnString += ':';
      returnString += x.minute.toString();
      returnString += 'pm';
    } else {
      returnString += (x.hour).toString();
      returnString += ':';
      returnString += x.minute.toString();
      returnString += 'am';
    }

    return returnString;
  }

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
                FirebaseFirestore.instance.collection('Calendar').snapshots(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    SizedBox(height: 50),
                    (successfullyCreatedNewEvent)
                        ? Text('Successfully created new event!',
                            style: TextStyle(fontSize: 18, color: Colors.green))
                        : Container(),
                    (successfullyCreatedNewEvent)
                        ? SizedBox(height: 50)
                        : Container(),
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          height: 25,
                          child: Center(
                              child: Text('Start Date/Time',
                                  style: TextStyle(fontSize: 20)))),
                      (!_startTimeOpen)
                          ? IconButton(
                              icon: (Icon(Icons.add)),
                              onPressed: () {
                                setState(() {
                                  (_startTimeOpen)
                                      ? _startTimeOpen = false
                                      : _startTimeOpen = true;
                                });
                              })
                          : IconButton(
                              icon: (Icon(Icons.remove)),
                              onPressed: () {
                                setState(() {
                                  (_startTimeOpen)
                                      ? _startTimeOpen = false
                                      : _startTimeOpen = true;
                                });
                              }),
                    ]),
                    Container(
                      //width: 275,
                      height: (_startTimeOpen) ? 150 : .01,
                      child: CupertinoDatePicker(
                        initialDateTime: _today,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _chosenStartDate = dateTime;
                          });
                        },
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          height: 25,
                          child: Center(
                              child: Text('End Date/Time',
                                  style: TextStyle(fontSize: 20)))),
                      (!_endTimeOpen)
                          ? IconButton(
                              icon: (Icon(Icons.add)),
                              onPressed: () {
                                setState(() {
                                  (_endTimeOpen)
                                      ? _endTimeOpen = false
                                      : _endTimeOpen = true;
                                });
                              })
                          : IconButton(
                              icon: (Icon(Icons.remove)),
                              onPressed: () {
                                setState(() {
                                  (_endTimeOpen)
                                      ? _endTimeOpen = false
                                      : _endTimeOpen = true;
                                });
                              }),
                    ]),
                    Container(
                      //width: 275,
                      height: (_endTimeOpen) ? 150 : .01,
                      child: CupertinoDatePicker(
                        initialDateTime: _today,
                        mode: CupertinoDatePickerMode.dateAndTime,
                        onDateTimeChanged: (dateTime) {
                          setState(() {
                            _chosenEndDate = dateTime;
                          });
                        },
                      ),
                    ),
                    Row(children: [SizedBox(height: 25)]),
                    Container(
                        width: 275,
                        child: TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              hintText: 'Location/Room',
                              labelText: 'Location/Room',
                              //errorText: _validateUser ? 'Value Cannot Be Empty' : null,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                //borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                //borderRadius: new BorderRadius.circular(25.7),
                              )),
                          onFieldSubmitted: (String value) {
                            locationValue = value;
                          },
                          onChanged: (String value) {
                            locationValue = value;
                          },
                        )),
                    Row(children: [SizedBox(height: 25)]),
                    Container(
                        width: 275,
                        child: TextFormField(
                          controller: _dresscodeController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              hintText: 'Dress Code',
                              labelText: 'Dress Code',
                              //errorText: _validatePass ? 'Value Cannot Be Empty' : null,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                //borderRadius: new BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                //borderRadius: new BorderRadius.circular(25.7),
                              )),
                          onFieldSubmitted: (String value) {
                            dresscodeValue = value;
                          },
                          onChanged: (String value) {
                            dresscodeValue = value;
                          },
                        )),
                    Row(children: [SizedBox(height: 25)]),
                    (globals.level > 0)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text(
                                  'Add to: ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                //Text('Menu'),
                                DropdownButton<String>(
                                  // iconEnabledColor: Colors.white,
                                  // iconDisabledColor: Colors.white,

                                  value: hintText,
                                  hint: Text('$hintText'),
                                  style: TextStyle(color: Colors.black),
                                  items: <String>['Personal', 'PBL']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      hintText = newValue;
                                      (newValue == 'Personal')
                                          ? calChoice = 0
                                          : calChoice = 1;
                                    });
                                  },
                                ),
                                Text(
                                  ' Calendar',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ])
                        : Container(),
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

                        if (globals.level < 1 && calChoice == 1) {
                          setState(() {
                            lowClearanceError = true;
                          });
                        } else {
                          lowClearanceError = false;
                        }

                        if (!_validateTitle &&
                            !(globals.level < 1 && calChoice == 1)) {
                          //equiv of allValid
                          if (locationValue == "") {
                            locationValue = "N/A";
                          }
                          if (dresscodeValue == "") {
                            dresscodeValue = "N/A";
                          }
                          setState(() {
                            successfullyCreatedNewEvent = true;
                            String printedStartDate = "";
                            String printedEndDate = "";
                            printedStartDate =
                                _changeToReadableDate(_chosenStartDate);
                            printedEndDate =
                                _changeToReadableDate(_chosenEndDate);
                            //printedDate += _chosenStartDate.toString().substring(startIndex)

                            FirebaseFirestore.instance
                                .collection("Calendar")
                                .doc(
                                    '${(snapshot.data.documents[snapshot.data.documents.length - 1]['entry'])}')
                                .set(
                              {
                                'Title': '$titleValue',
                                'Start': '$_chosenStartDate',
                                'End': '$_chosenEndDate',
                                'Location': '$locationValue',
                                'Dress Code': '$dresscodeValue',
                                'Calendar Choice': calChoice,
                                'Username': '${globals.username}',
                                'Print Start Date': '$printedStartDate',
                                'Print End Date': '$printedEndDate',
                                'Entry': snapshot.data.documents[
                                        snapshot.data.documents.length - 1]
                                    ['entry'],
                              },
                            );
                            int updateEntry = snapshot.data.documents[
                                        snapshot.data.documents.length - 1]
                                    ['entry'] +
                                1;
                            FirebaseFirestore.instance
                                .collection("Calendar")
                                .doc('Entry')
                                .update({'entry': updateEntry});
                            titleValue = "";
                            locationValue = "";
                            dresscodeValue = "";

                            _titleController.clear();
                            _locationController.clear();
                            _dresscodeController.clear();
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
            }));
  }
}
