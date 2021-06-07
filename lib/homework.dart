import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prof_frat_app/addHomework.dart';
import './globals.dart' as globals;

class HomeworkPage extends StatefulWidget {
  @override
  _HomeworkPageState createState() => new _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Homework'),
          actions: (globals.level == 100 || globals.level == 1000)
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new AddHomeworkPage()),
                      ) /*.then((value) {
                        setState(() {
                          final dateTime = DateTime.now();
                          _calendarController.setSelectedDay(
                            DateTime(
                                dateTime.year, dateTime.month, dateTime.day),
                            runCallback: true,
                          );
                        });
                      });*/
                          ;
                    },
                  )
                ]
              : null,
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Homework').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      // (globals.level == 100)
                      //     ? DataColumn(label: Text(''))
                      //     : null,
                      DataColumn(
                        label: Text('Title'),
                      ),
                      DataColumn(
                        label: Text('Due Date'),
                      ),
                      DataColumn(
                        label: Text('Additonal Notes'),
                      ),
                      // DataColumn(
                      //   label: Text('Phone Number'),
                      // ),
                      // DataColumn(
                      //   label: Text('Birthday'),
                      // ),
                    ],
                    rows: snapshot.data.documents
                        .map<DataRow>(((element) => DataRow(cells: <DataCell>[
                              // (globals.level == 100)
                              //     ? DataCell(Text(element['Title']))
                              //     : null,
                              DataCell(Text(element['Title'])),
                              DataCell(Text(element['Due Date'])),
                              DataCell(Text(element['Additional Notes'])),
                              // DataCell(Text(element['Phone Number'])),
                              // DataCell(Text(element['Birthday'])),
                            ])))
                        .toList(),
                  ));
            }));
  }
}
