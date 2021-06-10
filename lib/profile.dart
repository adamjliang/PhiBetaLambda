import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import './globals.dart' as globals;
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

//import 'package:font_awesome_flutter/_example/icons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //PickedFile _image;
  File _imageFile;
  var _passUnlock = false;
  var _birthdayUnlock = false;
  var _phoneUnlock = false;
  var _majorUnlock = false;
  var _yearUnlock = false;

  String usernameValue;
  bool changePassword = false;
  bool changeBirthday = false;
  bool changePhone = false;
  bool changeMajor = false;
  bool changeYear = false;
  bool changePicture = false;

  FocusNode _passFocus;
  var _setStatePasswordAgain = false;
  FocusNode _birthdayFocus;
  var _setStateBirthdayAgain = false;
  FocusNode _phoneFocus;
  var _setStatePhoneAgain = false;
  FocusNode _majorFocus;
  var _setStateMajorAgain = false;
  FocusNode _yearFocus;
  var _setStateYearAgain = false;

  @override
  void initState() {
    super.initState();

    _passFocus = FocusNode();
    _birthdayFocus = FocusNode();
    _phoneFocus = FocusNode();
    _majorFocus = FocusNode();
    _yearFocus = FocusNode();
  }

  @override
  void dispose() {
    _passFocus.dispose();
    _birthdayFocus.dispose();
    _phoneFocus.dispose();
    _majorFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  Future uploadImageToFirebase(BuildContext context) async {
    globals.globalChangePicture = true;
    //print('here');
    String fileName = _imageFile.toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => {print(value), globals.profileurl = value},
        );

    print('done');

    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AssetImage defaultpp = AssetImage('assets/default_profile_pic.jpg');
    Future getImage(BuildContext context) async {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = File(image.path);
        //_image = image;
        uploadImageToFirebase(context);
        //globals.userProfilePicture = _imageFile;
      });
    }

    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text(
              '${globals.firstName} ${globals.lastName}\'s Profile Page'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Usernames').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');

              if (_setStatePasswordAgain) {
                _passFocus.requestFocus();
              }

              if (_setStateBirthdayAgain) {
                _birthdayFocus.requestFocus();
              }

              if (_setStatePhoneAgain) {
                _phoneFocus.requestFocus();
              }

              if (_setStateMajorAgain) {
                _majorFocus.requestFocus();
              }

              if (_setStateYearAgain) {
                _yearFocus.requestFocus();
              }

              int iToUse = 0;
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                if (snapshot.data.documents[i]['Username'] ==
                    globals.username) {
                  iToUse = i;
                  usernameValue = globals.username;
                }
              }

              // any changes to the firebase database can start to be made
              // after the previous for loop
              var userProfilePicture = NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/phi-beta-lambda-calendar.appspot.com/o/uploads%2FFile%3A%20\'%2FUsers%2Fadamliang%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2FCF449B6A-2D5A-4D18-96ED-914F2E9DFA12%2Fdata%2FContainers%2FData%2FApplication%2F03D91332-AD26-4C98-9ED5-5E2BDC8108FD%2Ftmp%2Fdefault_profile_pic.jpg?alt=media&token=0ac5b69a-b2e9-4e77-9143-2bd26b08c449');
              if (snapshot.data.documents[iToUse]['ppurl'] != '' &&
                  snapshot.data.documents[iToUse]['ppurl'] != 'null') {
                userProfilePicture =
                    NetworkImage(snapshot.data.documents[iToUse]['ppurl']);
              }

              if (globals.globalChangePicture && globals.profileurl != null) {
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${snapshot.data.documents[iToUse]['Password']}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${snapshot.data.documents[iToUse]['Birthday']}',
                  'Major': '${snapshot.data.documents[iToUse]['Major']}',
                  'Year': '${snapshot.data.documents[iToUse]['Year']}',
                  'Phone Number':
                      '${snapshot.data.documents[iToUse]['Phone Number']}',
                  'ppurl': '${globals.profileurl}',
                });
                globals.globalChangePicture = false;
              }

              if (changeYear) {
                print('here');
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${snapshot.data.documents[iToUse]['Password']}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${snapshot.data.documents[iToUse]['Birthday']}',
                  'Major': '${snapshot.data.documents[iToUse]['Major']}',
                  'Year': '${globals.changedText}',
                  'Phone Number':
                      '${snapshot.data.documents[iToUse]['Phone Number']}',
                  'ppurl': '${snapshot.data.documents[iToUse]['ppurl']}',
                });
                changeYear = false;
              }
              if (changePassword) {
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${globals.changedText}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${snapshot.data.documents[iToUse]['Birthday']}',
                  'Major': '${snapshot.data.documents[iToUse]['Major']}',
                  'Year': '${snapshot.data.documents[iToUse]['Year']}',
                  'Phone Number':
                      '${snapshot.data.documents[iToUse]['Phone Number']}',
                  'ppurl': '${snapshot.data.documents[iToUse]['ppurl']}',
                });
                changePassword = false;
              }
              if (changeBirthday) {
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${snapshot.data.documents[iToUse]['Password']}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${globals.changedText}',
                  'Major': '${snapshot.data.documents[iToUse]['Major']}',
                  'Year': '${snapshot.data.documents[iToUse]['Year']}',
                  'Phone Number':
                      '${snapshot.data.documents[iToUse]['Phone Number']}',
                  'ppurl': '${snapshot.data.documents[iToUse]['ppurl']}',
                });
                changeBirthday = false;
              }
              if (changePhone) {
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${snapshot.data.documents[iToUse]['Password']}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${snapshot.data.documents[iToUse]['Birthday']}',
                  'Major': '${snapshot.data.documents[iToUse]['Major']}',
                  'Year': '${snapshot.data.documents[iToUse]['Year']}',
                  'Phone Number': '${globals.changedText}',
                  'ppurl': '${snapshot.data.documents[iToUse]['ppurl']}',
                });
                changePhone = false;
              }
              if (changeMajor) {
                FirebaseFirestore.instance
                    .collection("Usernames")
                    .doc('$usernameValue')
                    .set({
                  'First Name':
                      '${snapshot.data.documents[iToUse]['First Name']}',
                  'Last Name':
                      '${snapshot.data.documents[iToUse]['Last Name']}',
                  'Username': '${snapshot.data.documents[iToUse]['Username']}',
                  'Password': '${snapshot.data.documents[iToUse]['Password']}',
                  'Clearance': snapshot.data.documents[iToUse]['Clearance'],
                  'Birthday': '${snapshot.data.documents[iToUse]['Birthday']}',
                  'Major': '${globals.changedText}',
                  'Year': '${snapshot.data.documents[iToUse]['Year']}',
                  'Phone Number':
                      '${snapshot.data.documents[iToUse]['Phone Number']}',
                  'ppurl': '${snapshot.data.documents[iToUse]['ppurl']}',
                });
                changeMajor = false;
              }

              var _passwordController = TextEditingController(
                  text: '${snapshot.data.documents[iToUse]['Password']}');
              var _birthdayController = TextEditingController(
                  text: '${snapshot.data.documents[iToUse]['Birthday']}');
              var _phoneController = TextEditingController(
                  text: '${snapshot.data.documents[iToUse]['Phone Number']}');
              var _majorController = TextEditingController(
                  text: '${snapshot.data.documents[iToUse]['Major']}');
              var _yearController = TextEditingController(
                  text: '${snapshot.data.documents[iToUse]['Year']}');

              return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      getImage(context);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: SizedBox(
                            width: 180,
                            height: 180,
                            child: (snapshot.data.documents[iToUse]['ppurl'] !=
                                    'null')
                                ? new Image(
                                    image: userProfilePicture,
                                    fit: BoxFit.fill,
                                  )
                                : new Image(image: defaultpp, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Full Name',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 150,
                        margin: EdgeInsets.all(15),
                        child: Text('${globals.firstName} ${globals.lastName}',
                            style: TextStyle(
                              fontSize: 18,
                            )))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Username',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 150,
                        margin: EdgeInsets.all(15),
                        child: Text('${globals.username}',
                            style: TextStyle(
                              fontSize: 18,
                            )))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Password',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () => {
                          setState(() {
                            _passUnlock = true;
                            _setStatePasswordAgain = true;

                            _setStateBirthdayAgain = false;
                            _setStatePhoneAgain = false;
                            _setStateMajorAgain = false;
                            _setStateYearAgain = false;

                            _birthdayUnlock = false;
                            _phoneUnlock = false;
                            _majorUnlock = false;
                            _yearUnlock = false;
                          }),
                        },
                      ),
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          focusNode: _passFocus,
                          obscureText: !_passUnlock,
                          enabled: _passUnlock,
                          controller: _passwordController,
                          //'${snapshot.data.documents[iToUse]['Password']}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onSubmitted: _submittedNewFieldPassword,
                        ))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Role',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width - 150,
                      margin: EdgeInsets.all(15),
                      child: (globals.level > 0)
                          ? Text('Admin',
                              style: TextStyle(
                                fontSize: 18,
                              ))
                          : (globals.level == 0)
                              ? Text('Brother',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ))
                              : Text('Pledge',
                                  style: TextStyle(
                                    fontSize: 18,
                                  )),
                    ),
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Birthday',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () => {
                          setState(() {
                            _birthdayUnlock = true;
                            _setStatePasswordAgain = false;

                            _setStateBirthdayAgain = true;
                            _setStatePhoneAgain = false;
                            _setStateMajorAgain = false;
                            _setStateYearAgain = false;

                            _passUnlock = false;
                            _phoneUnlock = false;
                            _majorUnlock = false;
                            _yearUnlock = false;
                          }),
                        },
                      ),
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),

                          enabled: _birthdayUnlock,
                          controller: _birthdayController,
                          focusNode: _birthdayFocus,
                          //'${snapshot.data.documents[iToUse]['Password']}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onSubmitted: _submittedNewFieldBirthday,
                        ))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Phone #',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () => {
                          setState(() {
                            _phoneUnlock = true;
                            _setStatePasswordAgain = false;

                            _setStateBirthdayAgain = false;
                            _setStatePhoneAgain = true;
                            _setStateMajorAgain = false;
                            _setStateYearAgain = false;

                            _passUnlock = false;
                            _birthdayUnlock = false;
                            _majorUnlock = false;
                            _yearUnlock = false;
                          }),
                        },
                      ),
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          //keyboardType: TextInputType.number,
                          enabled: _phoneUnlock,
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          //'${snapshot.data.documents[iToUse]['Password']}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onSubmitted: _submittedNewFieldPhone,
                        ))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Major',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () => {
                          setState(() {
                            _majorUnlock = true;
                            _setStatePasswordAgain = false;

                            _setStateBirthdayAgain = false;
                            _setStatePhoneAgain = false;
                            _setStateMajorAgain = true;
                            _setStateYearAgain = false;

                            _passUnlock = false;
                            _birthdayUnlock = false;
                            _phoneUnlock = false;
                            _yearUnlock = false;
                          }),
                        },
                      ),
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.all(15),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          enabled: _majorUnlock,
                          controller: _majorController,
                          focusNode: _majorFocus,
                          //'${snapshot.data.documents[iToUse]['Password']}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onSubmitted: _submittedNewFieldMajor,
                        ))
                  ]),
                  Row(children: [
                    Container(
                        height: 30,
                        width: 90,
                        margin: EdgeInsets.all(15),
                        child: Text('Year',
                            style: TextStyle(
                              fontSize: 18,
                            ))),
                    Container(
                      height: 30,
                      width: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                        ),
                        onPressed: () => {
                          setState(() {
                            _yearUnlock = true;
                            _setStatePasswordAgain = false;

                            _setStateBirthdayAgain = false;
                            _setStatePhoneAgain = false;
                            _setStateMajorAgain = false;
                            _setStateYearAgain = true;

                            _passUnlock = false;
                            _birthdayUnlock = false;
                            _phoneUnlock = false;
                            _majorUnlock = false;
                          }),
                        },
                      ),
                    ),
                    Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        margin: EdgeInsets.all(15),
                        child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            enabled: _yearUnlock,
                            controller: _yearController,
                            focusNode: _yearFocus,
                            //'${snapshot.data.documents[iToUse]['Password']}',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            onSubmitted:
                                _submittedNewFieldYear //_showDeleteAlert(context),
                            ))
                  ]),
                ]),
              );
            }));
  }

  _submittedNewFieldPassword(String x) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          _passUnlock = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _passUnlock = false;
          changePassword = true;
          globals.changedText = x;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WARNING"),
      content: Text(
          'You are about to change your password. This new password will be in effect immediately. Are you sure you want to change your password?'),
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

  _submittedNewFieldBirthday(String x) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          _birthdayUnlock = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _birthdayUnlock = false;
          changeBirthday = true;
          globals.changedText = x;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text('Are you sure you want to change your birthday?'),
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

  _submittedNewFieldYear(String x) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          _yearUnlock = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _yearUnlock = false;
          changeYear = true;
          globals.changedText = x;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text('Are you sure you want to change your year?'),
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

  _submittedNewFieldMajor(String x) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          _majorUnlock = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _majorUnlock = false;
          changeMajor = true;
          globals.changedText = x;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text('Are you sure you want to change your major?'),
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

  _submittedNewFieldPhone(String x) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          _phoneUnlock = false;
        });
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _phoneUnlock = false;
          changePhone = true;
          globals.changedText = x;
        });

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text('Are you sure you want to change your phone number?'),
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
}
