import 'package:cloud_firestore/cloud_firestore.dart';
import './userInfoList.dart';
import 'package:flutter/material.dart';
import './globals.dart' as globals;

class AddUsersPage extends StatefulWidget {
  @override
  _AddUsersPageState createState() => new _AddUsersPageState();
}

class _AddUsersPageState extends State<AddUsersPage> {
bool duplicateUser = false;
int clearanceChoice = 0;
bool successfullyCreatedNewUser = false;
String previousUsername = "";
bool allValid = true;
String hintText = 'Brother';
bool _validateFirst = false;
bool _validateLast = false;
bool _validateUser = false;
bool _validatePass = false;
String firstNameValue = "";
String lastNameValue = "";
String usernameValue = "";
String passwordValue = "";
var _firstNameController = TextEditingController();
var _lastNameController = TextEditingController();
var _usernameController = TextEditingController();
var _passwordController = TextEditingController();
  // Widget _buildListItem(BuildContext context, DocumentSnapshot document){
  //   return ListTile(
  //     title: Row(
  //       children: [
  //         Align(
  //           alignment: Alignment.centerLeft,
  //           child:
  //             Container(
  //           decoration: const BoxDecoration(
  //             color: Color(0xffddddff),
  //           ),
  //           padding: const EdgeInsets.all(10.0),
  //           child: Text(
  //             document['Username'].toString(),
              
  //           )
  //         ),
  //         ),
          
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child:
  //             Container(
  //           decoration: const BoxDecoration(
  //             color: Color(0xffddddff),
  //           ),
  //           padding: const EdgeInsets.all(10.0),
  //           child: Text(
  //             document['Password'].toString(),
              
  //           )
  //         ),
  //         ),
  //       ]
  //     )
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: globals.pblblue,
        title: new Text('Add New Users'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.supervisor_account),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new UserInfoListPage()),
              );
            }
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Usernames').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return Column(
            children: [
              Row(
                children: [ 
                  SizedBox(height: 50)
                ]
              ),
              (successfullyCreatedNewUser)?Text('Successfully created new user "$previousUsername"', style: TextStyle(fontSize: 18, color: Colors.green)):Container(),
              (successfullyCreatedNewUser)?SizedBox(height: 50):Container(),
              (duplicateUser)?Text('Error: Username, "$usernameValue" already exists.', style: TextStyle(fontSize: 18, color: Colors.red)):Container(),
              (duplicateUser)?SizedBox(height: 50):Container(),
              Container(
                width: 275,
                child: 
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'First Name',
                      labelText: 'First Name',
                      errorText: _validateFirst ? 'Value Cannot Be Empty' : null,
                      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      )
                    ),
                    onFieldSubmitted: (String value){
                      firstNameValue = value;
                    },
                    onChanged: (String value){
                      firstNameValue = value;
                    },
                  )
              
              ),
              Row(
                children: [ 
                  SizedBox(height: 25)
                ]
              ),
              Container(
                width: 275,
                child: 
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Last Name',
                      labelText: 'Last Name',
                      errorText: _validateLast ? 'Value Cannot Be Empty' : null,
                      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      )
                    ),
                    onFieldSubmitted: (String value){
                      lastNameValue = value;
                    },
                    onChanged: (String value){
                      lastNameValue = value;
                    },
                  )
              
              ),
              Row(
                children: [ 
                  SizedBox(height: 25)
                ]
              ),
              Container(
                width: 275,
                child: 
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Username',
                      labelText: 'Username',
                      errorText: _validateUser ? 'Value Cannot Be Empty' : null,
                      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      )
                    ),
                    onFieldSubmitted: (String value){
                        usernameValue = value;
                    },
                    onChanged: (String value){
                      usernameValue = value;
                    },
                  )
              
              ),
              Row(
                children: [ 
                  SizedBox(height: 25)
                ]
              ),
              Container(
                width: 275,
                child: 
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Password',
                      labelText: 'Password',
                      errorText: _validatePass ? 'Value Cannot Be Empty' : null,
                      contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        //borderRadius: new BorderRadius.circular(25.7),
                      )
                    ),
                    onFieldSubmitted: (String value){
                      passwordValue = value;
                    },
                    onChanged: (String value){
                      passwordValue = value;
                    },
                  )
              
              ),
              Row(
                children: [ 
                  SizedBox(height: 25)
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  Text('Member Type: '),
                  //Text('Menu'),
                  DropdownButton<String>(
                    // iconEnabledColor: Colors.white,
                    // iconDisabledColor: Colors.white,
                    
                    value: hintText,
                    //hint: Text('$hintText'),
                    style: TextStyle(color: Colors.black),
                    items: <String>['Pledge', 'Brother', 'Admin'].map((String value) {
                      return DropdownMenuItem<String>(
                        
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (String newValue){
                      setState(() {
                        hintText = newValue;
                        (newValue == 'Admin')?clearanceChoice = 1:(newValue == 'Brother')?clearanceChoice = 0:clearanceChoice = -1;
                      });
                    },
                  ),
                ]
              ),
              Row(
                children: [ 
                  SizedBox(height: 25)
                ]
              ),
              InkWell(
              onTap: () {
                if (firstNameValue == ""){
                  setState(() {
                    _validateFirst = true;
                    
                  });
                }
                else{
                  _validateFirst = false;
                }
                if (lastNameValue == ""){
                  setState(() {
                    _validateLast = true;
                    
                  });
                }
                else{
                  _validateLast = false;
                }
                if (usernameValue == ""){
                  setState(() {
                    _validateUser = true;
                    
                  });
                }
                else{
                  _validateUser = false;
                }
                if (passwordValue == ""){
                  
                  setState(() {
                    _validatePass = true;
                  });
                }
                else{ 
                  _validatePass = false;
                }

                if (!_validateFirst && !_validateLast && !_validateUser && !_validatePass){
                  allValid = true;
                }
                else{
                  allValid = false;
                }

                if (allValid){
                  for (int i = 0; i < snapshot.data.documents.length; i++){
                    if (snapshot.data.documents[i]['Username'] == usernameValue){
                      allValid = false;
                      duplicateUser = true;
                    }
                  }
                }

                if (allValid){
                  setState(() {
                    successfullyCreatedNewUser = true;
                    previousUsername = usernameValue;

                    Firestore.instance.collection("Usernames").document('$usernameValue').setData(
                      {'First Name': '$firstNameValue', 
                      'Last Name': '$lastNameValue', 
                      'Username': '$usernameValue', 
                      'Password': '$passwordValue',
                      'Clearance': clearanceChoice,
                      'Birthday': 'null',
                      'Major': 'null',
                      'Year': 'null',
                      'Phone Number': 'null',
                      },
                    
                    );
                    
                    firstNameValue = "";
                    lastNameValue = "";
                    usernameValue = "";
                    passwordValue = "";
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _usernameController.clear();
                    _passwordController.clear();
                    duplicateUser = false;
                    
                });
                }
                else{
                  setState(() {
                    successfullyCreatedNewUser = false;
                  });
                }
                

                
              },
              child:
                Align(
              alignment: Alignment.center,
              child:
            Container(
              color: globals.pblblue,
              width: 175,
              height: 50,
              child: 
                Align(
                  alignment: Alignment.center,
                  child:
                Text(
                  'Add User',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  )
                ),
                )
              
            ),
            ),
            ),
            ]
          );
          
          // return ListView.builder(
          //   itemExtent: 80.0,
          //   itemCount: snapshot.data.documents.length,
          //   itemBuilder: (context, index) =>
          //     _buildListItem(context, snapshot.data.documents[index]),
            
          // );
        }
      )
    );
  }
}