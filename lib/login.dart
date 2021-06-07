import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  _LoginStatePage createState() => new _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {
  // @override
  // void dispose(){
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: globals.pblblue,
          title: new Text('Login Page'),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Usernames').snapshots(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 350,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintText: 'Username',
                                  labelText: 'Username',
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius:
                                        new BorderRadius.circular(25.7),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white),
                                    borderRadius:
                                        new BorderRadius.circular(25.7),
                                  )),
                              onFieldSubmitted: (String value) {
                                globals.inputUsername = value;
                              },
                              onChanged: (String value) {
                                globals.inputUsername = value;
                              },
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: 350,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                hintText: 'Password',
                                labelText: 'Password',
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                              onFieldSubmitted: (String value) {
                                globals.inputPassword = value;
                              },
                              onChanged: (String value) {
                                globals.inputPassword = value;
                              },
                            )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          int finish = snapshot.data.documents.length;
                          for (int i = 0; i < finish; i++) {
                            if ((snapshot.data.documents[i]['Username'] ==
                                    globals.inputUsername &&
                                snapshot.data.documents[i]['Password'] ==
                                    globals.inputPassword)) {
                              globals.refreshLogin = true;
                              globals.firstName =
                                  snapshot.data.documents[i]['First Name'];
                              globals.lastName =
                                  snapshot.data.documents[i]['Last Name'];
                              globals.level =
                                  snapshot.data.documents[i]['Clearance'];
                              globals.username =
                                  snapshot.data.documents[i]['Username'];

                              Navigator.pop(context);
                              i = finish;
                            }
                          }
                          //print(snapshot.data.documents[0]['Username']);
                          if (!globals.refreshLogin) {
                            setState(() {
                              globals.hasErrorLogin = true;
                            });
                          }
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                              color: Colors.green,
                              width: 175,
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                              )),
                        ),
                      ),
                      (globals.hasErrorLogin)
                          ? Text('Incorrect username or password!',
                              style: TextStyle(
                                color: Colors.red,
                              ))
                          : Container(),
                    ],
                  ));
            }));
  }
}
