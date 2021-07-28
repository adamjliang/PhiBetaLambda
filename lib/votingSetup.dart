import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:prof_frat_app/addHomework.dart';
import './globals.dart' as globals;

class VotingSetupPage extends StatefulWidget {
  @override
  _VotingSetupPageState createState() => new _VotingSetupPageState();
}

class _VotingSetupPageState extends State<VotingSetupPage> {
  final _formKey = GlobalKey<FormState>();
  static List<String> friendsList = [null];
  TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFieldsList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row only
            _addRemoveButton(i == friendsList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFieldsList;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Voting Setup'),
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
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name textfield
                        Padding(
                          padding: const EdgeInsets.only(right: 32.0),
                          child: TextFormField(
                            controller: _nameController,
                            decoration:
                                InputDecoration(hintText: 'Enter your name'),
                            validator: (v) {
                              if (v.trim().isEmpty)
                                return 'Please enter something';
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Add Friends',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        ..._getFriends(),
                        SizedBox(
                          height: 40,
                        ),
                        FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //_formKey.currentState.save();
                              // print(friendsList);
                              for (int i = 0; i < friendsList.length; i++) {
                                String candidate = friendsList[i];
                                FirebaseFirestore.instance
                                    .collection("Voting")
                                    .doc('$candidate')
                                    .set(
                                  {
                                    'Name': '$candidate',
                                    'Voting': 0,
                                  },
                                );
                              }
                              globals.gFriendsList = friendsList;
                              _formKey.currentState.reset();
                            }
                          },
                          child: Text('Submit'),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text =
          _VotingSetupPageState.friendsList[widget.index] ?? '';
    });
    return TextFormField(
      controller: _nameController,
      // save text field data in friends list at index
      // whenever text field value changes
      onChanged: (v) => _VotingSetupPageState.friendsList[widget.index] = v,
      decoration: InputDecoration(hintText: 'Enter your friend\'s name'),
      validator: (v) {
        if (v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
