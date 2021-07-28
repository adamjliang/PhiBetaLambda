import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './globals.dart' as globals;
import './viewProfile.dart';

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
            stream:
                FirebaseFirestore.instance.collection('Usernames').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return InkWell(
                  onTap: () {},
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text('Full Name'),
                          ),
                          DataColumn(
                            label: Text('Profile'),
                          ),
                        ],
                        rows: snapshot.data.documents
                            .map<DataRow>(((element) =>
                                DataRow(cells: <DataCell>[
                                  DataCell(
                                      Text(element['First Name'] +
                                          ' ' +
                                          element['Last Name']), onTap: () {
                                    _profilePage(element['First Name']);
                                  }),
                                  DataCell(Icon(Icons.account_box_outlined),
                                      onTap: () {
                                    globals.viewFirstName =
                                        element['First Name'];
                                    globals.viewLastName = element['Last Name'];
                                    globals.viewBirthday = element['Birthday'];
                                    globals.viewMajor = element['Major'];
                                    globals.viewPhoneNumber =
                                        element['Phone Number'];
                                    globals.viewYear = element['Year'];
                                    globals.viewUsername = element['Username'];
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new ViewProfilePage()),
                                    );
                                  })
                                ])))
                            .toList(),
                      )));
            }));
  }
}

void _profilePage(String fullName) {
  print('yo');
}
