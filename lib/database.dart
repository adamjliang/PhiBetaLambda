import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;



class DataBasePage extends StatefulWidget {
  @override
  _DataBasePageState createState() => new _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: globals.pblblue,
        title: new Text('Brothers Database'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Usernames').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: 
              DataTable(
                columns: [
                  DataColumn(
                    label: Text('Full Name'),
                  ),
                  DataColumn(
                    label: Text('Year'),
                  ),
                  DataColumn(
                    label: Text('Major'),
                  ),
                  DataColumn(
                    label: Text('Phone Number'),
                  ),
                  DataColumn(
                    label: Text('Birthday'),
                  ),
                ],
                rows: snapshot.data.documents.map<DataRow>(((element) => DataRow(
                  
                  cells: <DataCell>[
                    DataCell(Text(element['First Name'] + ' ' +  element['Last Name'])),
                    DataCell(Text(element['Year'])),
                    DataCell(Text(element['Major'])),
                    DataCell(Text(element['Phone Number'])),
                    DataCell(Text(element['Birthday'])),
                  ]
                ))
              ).toList(),
          ));
        }
      )
    );
  }
}