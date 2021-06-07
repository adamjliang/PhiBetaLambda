import 'package:cloud_firestore/cloud_firestore.dart';
import './userInfoList.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;

class AddHomeworkPage extends StatefulWidget {
  @override
  _AddHomeworkPageState createState() => new _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  int clearanceChoice = 0;
  bool successfullyCreatedNewHomework = false;
  String previousUsername = "";
  bool allValid = true;
  String hintText = 'Brother';
  bool _validateTitle = false;
  bool _validateDate = false;
  bool _validateAddNotes = false;
  String titleValue = "";
  String dateValue = "";
  String addNotesValue = "";
  var _titleController = TextEditingController();
  var _dateController = TextEditingController();
  var _addNotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Add New Homework'),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('HomeworkEntry')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return Column(children: [
                Row(children: [SizedBox(height: 50)]),
                (successfullyCreatedNewHomework)
                    ? Text('Successfully created new homework!',
                        style: TextStyle(fontSize: 18, color: Colors.green))
                    : Container(),
                (successfullyCreatedNewHomework)
                    ? SizedBox(height: 50)
                    : Container(),
                Container(
                    width: 275,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Title',
                          labelText: 'Homework Title',
                          errorText:
                              _validateTitle ? 'Value Cannot Be Empty' : null,
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
                        titleValue = value;
                      },
                      onChanged: (String value) {
                        titleValue = value;
                      },
                    )),
                Row(children: [SizedBox(height: 25)]),
                Container(
                    width: 275,
                    child: TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Due Date',
                          labelText: 'Due Date',
                          errorText:
                              _validateDate ? 'Value Cannot Be Empty' : null,
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
                        dateValue = value;
                      },
                      onChanged: (String value) {
                        dateValue = value;
                      },
                    )),
                Row(children: [SizedBox(height: 25)]),
                Container(
                    width: 275,
                    child: TextFormField(
                      controller: _addNotesController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[300],
                          hintText: 'Addtional Notes',
                          labelText: 'Addtional Notes',
                          errorText: _validateAddNotes
                              ? 'Value Cannot Be Empty'
                              : null,
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
                        addNotesValue = value;
                      },
                      onChanged: (String value) {
                        addNotesValue = value;
                      },
                    )),
                Row(children: [SizedBox(height: 25)]),
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
                    if (dateValue == "") {
                      setState(() {
                        _validateDate = true;
                      });
                    } else {
                      _validateDate = false;
                    }
                    if (addNotesValue == "") {
                      setState(() {
                        _validateAddNotes = true;
                      });
                    } else {
                      _validateAddNotes = false;
                    }

                    if (!_validateTitle &&
                        !_validateDate &&
                        !_validateAddNotes) {
                      allValid = true;
                    } else {
                      allValid = false;
                    }

                    if (allValid) {
                      setState(() {
                        successfullyCreatedNewHomework = true;

                        // print(snapshot.data
                        //         .documents[snapshot.data.documents.length - 1]
                        //     ['entry']);

                        FirebaseFirestore.instance
                            .collection("Homework")
                            .doc(
                                '${(snapshot.data.documents[snapshot.data.documents.length - 1]['entry'])}')
                            .set(
                          {
                            'Additional Notes': '$addNotesValue',
                            'Due Date': '$dateValue',
                            'Title': '$titleValue',
                            // 'Entry': snapshot.data.documents[
                            //     snapshot.data.documents.length - 1]['entry'],
                          },
                        );

                        int updateEntry = snapshot.data.documents[
                                snapshot.data.documents.length - 1]['entry'] +
                            1;

                        FirebaseFirestore.instance
                            .collection("HomeworkEntry")
                            .doc('Entry')
                            .update({'entry': updateEntry});

                        titleValue = "";
                        dateValue = "";
                        addNotesValue = "";

                        _titleController.clear();
                        _dateController.clear();
                        _addNotesController.clear();
                      });
                    } else {
                      setState(() {
                        successfullyCreatedNewHomework = false;
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
                          child: Text('Add Homework',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              )),
                        )),
                  ),
                ),
              ]);

              // return ListView.builder(
              //   itemExtent: 80.0,
              //   itemCount: snapshot.data.documents.length,
              //   itemBuilder: (context, index) =>
              //     _buildListItem(context, snapshot.data.documents[index]),

              // );
            }));
  }
}
