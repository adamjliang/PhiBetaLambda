import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import './globals.dart' as globals;

class UserInfoListPage extends StatefulWidget {
  @override
  _UserInfoListPageState createState() => new _UserInfoListPageState();
}

class _UserInfoListPageState extends State<UserInfoListPage> {
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: (document['Clearance'] < 3)
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Expanded(
              //   child: Text(
              //     document['Username'],
              //     //style: Theme.of(context).textTheme.headline1,
              //   ),
              // ),
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffddddff),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['First Name'].toString(),
                  )),
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffddddff),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['Last Name'].toString(),
                  )),
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffddddff),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['Username'].toString(),
                  )),
              // Container(
              //   decoration: const BoxDecoration(
              //     color: Color(0xffddddff),
              //   ),
              //   padding: const EdgeInsets.all(10.0),
              //   child: Text(
              //     document['Password'].toString(),

              //   )
              // ),
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffddddff),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['Clearance'].toString(),
                  )),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDeleteAlert(context, document);
                },
              )
            ])
          : null,
    );
  }

  _showDeleteAlert(BuildContext context, DocumentSnapshot document) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        FirebaseFirestore.instance
            .collection("Usernames")
            .doc(document["Username"].toString())
            .delete();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
          'Are you sure you want to delete user: ${document["Username"].toString()}'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('User Info List'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Usernames').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');

              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data.documents[index]),
              );
            }));
  }
}
