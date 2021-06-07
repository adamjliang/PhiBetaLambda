import 'package:flutter/material.dart';
import 'package:prof_frat_app/addUsers.dart';
//import 'package:prof_frat_app/custom_icons_icons.dart';
import './profile.dart';
import './login.dart';
import './calendar.dart';
import './database.dart';
import './homework.dart';
import './globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  _launchForm() async {
    if (await canLaunch(globals.aform)) {
      await launch(globals.aform);
    } else {
      throw 'Could not launch ${globals.aform}';
    }
  }

  _launchWebsite() async {
    if (await canLaunch(globals.websiteurl)) {
      await launch(globals.websiteurl);
    } else {
      throw 'Could not launch ${globals.websiteurl}';
    }
  }

  _launchZoom() async {
    if (await canLaunch(globals.zoomurl)) {
      await launch(globals.zoomurl);
    } else {
      throw 'Could not launch ${globals.zoomurl}';
    }
  }

  // _launchDatabase() async {
  //   if (await canLaunch(globals.databaseurl)) {
  //     await launch(globals.databaseurl);
  //   }
  //   else{
  //     throw 'Could not launch ${globals.databaseurl}';
  //   }
  // }

  // _launchCalendar() async {
  //   if (await canLaunch(globals.calendarurl)) {
  //     await launch(globals.calendarurl);
  //   }
  //   else{
  //     throw 'Could not launch ${globals.calendarurl}';
  //   }
  // }

  // _launchRush() async {
  //   if (await canLaunch(globals.rushurl)) {
  //     await launch(globals.rushurl);
  //   }
  //   else{
  //     throw 'Could not launch ${globals.rushurl}';
  //   }
  // }
  void _printCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    /*Variables*/
    const pblblue = const Color(0xff003366);
    var pbllogo = AssetImage('assets/pbllogo.png');
    var bgimage = AssetImage('assets/pblbgimage.jpg');

    return FutureBuilder<int>(
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: pblblue,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                (globals.logged)
                    ? IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(MdiIcons.checkUnderlineCircleOutline),
                        onPressed: () {
                          _printCurrentLocation();
                        },
                      )
                    : IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(MdiIcons.checkUnderlineCircleOutline),
                        onPressed: () {
                          _printCurrentLocation();
                        },
                      ),
                (globals.logged)
                    ? IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(right: 28.0),
                        icon: Icon(MdiIcons.formSelect),
                        onPressed: () {
                          _launchForm();
                        },
                      )
                    : Container(),
                (globals.logged)
                    ? IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(left: 28.0),
                        icon: Icon(Icons.today),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new CalendarPage()),
                          );
                        },
                      )
                    : Container(),
                (!globals.logged)
                    ? IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(right: 28.0),
                        icon: Icon(Icons.vpn_key),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new LoginPage()),
                          ).then((value) {
                            setState(() {
                              globals.hasErrorLogin = false;
                              if (globals.refreshLogin) {
                                globals.logged = true;
                                globals.usernameLogged = globals.inputUsername;
                                globals.refreshLogin = false;
                                //globals.firstName = globals.passAndFirst[globals.inputPassword];
                                //globals.lastName = globals.passAndLast[globals.inputPassword];
                              }
                            });
                          });
                        },
                      )
                    : IconButton(
                        color: Colors.white,
                        iconSize: 30.0,
                        padding: EdgeInsets.only(right: 28.0),
                        icon: Icon(Icons.account_circle),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new ProfilePage()),
                          );
                        },
                      )
              ],
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            backgroundColor: pblblue,
            centerTitle: true,
            leading: new Padding(
              padding: const EdgeInsets.all(4),
              child: new Image(image: pbllogo),
            ),
            title: new Text('Phi Beta Lambda - Michigan',
                style: TextStyle(
                  fontSize: 16,
                )),

            // actions: <Widget>[
            //   new IconButton(icon: new Icon(Icons.menu, color: Colors.white), onPressed: null)
            // ],
          ),
        ),
        endDrawer: new Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
            ),
            child: Drawer(
                child: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
                DrawerHeader(
                  child: new Container(
                      color: pblblue,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('ΦBΛ',
                            style: TextStyle(
                              fontSize: 60,
                              color: globals.logoyellow,
                            )),
                      )),
                ),
                (globals.logged)
                    ? ListTile(
                        title: new Center(
                            child:
                                Text('Welcome brother, ${globals.lastName}')),
                      )
                    : Container(),
                // (!globals.logged)?
                // ListTile(
                //   title: new Center( child: Text('Brother Login')),
                //   onTap: () {
                //     Navigator.push(context, new MaterialPageRoute(
                //       builder: (BuildContext context) => new LoginPage()),
                //     ).then((value) {
                //       setState(() {
                //         globals.hasErrorLogin = false;
                //         if (globals.refreshLogin){
                //           globals.logged = true;
                //           globals.usernameLogged = globals.inputUsername;
                //           globals.refreshLogin = false;
                //           //globals.firstName = globals.passAndFirst[globals.inputPassword];
                //           //globals.lastName = globals.passAndLast[globals.inputPassword];
                //         }

                //       });
                //     });

                //   }
                // ):Container(),
                // (globals.logged)?
                // ListTile(
                //   title: new Center( child: Text('Profile')),
                //   onTap: () {
                //     Navigator.push(context, new MaterialPageRoute(
                //       builder: (BuildContext context) => new ProfilePage()),
                //     );
                //   }
                // ):Container(),
                (globals.logged &&
                        (globals.level == -1 ||
                            globals.level == 100 ||
                            globals.level == 1000))
                    ? ListTile(
                        title: new Center(child: Text('Homework')),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new HomeworkPage()),
                          );
                        })
                    : Container(),
                ((globals.logged && globals.level > 0 && globals.level < 99) ||
                        globals.logged && globals.level == 1000)
                    ? ListTile(
                        title: new Center(child: Text('Add/Delete Users')),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new AddUsersPage()),
                          );
                        })
                    : Container(),
                // (globals.logged)?
                // ListTile(
                //   title: new Center( child: Text('Calendar')),
                //   onTap: () {
                //     Navigator.push(context, new MaterialPageRoute(
                //       builder: (BuildContext context) => new CalendarPage()),
                //     );
                //   }
                // ):Container(),
                // (globals.logged)?
                // ListTile(
                //   title: new Center( child: Text('Absence Form')),
                //   onTap: () {
                //     _launchForm();
                //   }
                // ):Container(),
                (globals.logged)
                    ? ListTile(
                        title: new Center(child: Text('Brothers Database')),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new DataBasePage()),
                          );
                        })
                    : Container(),
                ListTile(
                    title: new Center(child: Text('Website')),
                    onTap: () {
                      _launchWebsite();
                    }),

                (globals.logged)
                    ? ListTile(
                        title: new Center(child: Text('Chapter Link')),
                        onTap: () {
                          _launchZoom();
                        })
                    : Container(),
                // (globals.logged)?
                // ListTile(
                //   title: new Center( child: Text('Event Check-In')),
                //   onTap: () {
                //     _launchRush();
                //   }
                // ):
                // ListTile(
                //   title: new Center( child: Text('Rush Check-In')),
                //   onTap: () {
                //     _launchRush();
                //   }
                // ),
                (globals.logged)
                    ? ListTile(
                        title: new Center(child: Text('Sign Out')),
                        onTap: () {
                          setState(() {
                            globals.logged = false;
                            globals.username = "";
                            globals.inputUsername = "";
                            globals.inputPassword = "";
                          });
                        })
                    : Container(),
              ]).toList(),
            ))),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: bgimage,
              fit: BoxFit.cover,
            )),
            child: Center(
                child: Column(children: [
              SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  height: 115,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 75),
                          child: Text('',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 70,
                              ))))),
              SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text('',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 70,
                              ))))),
              // SizedBox(
              //   width: double.infinity,
              //   height: 75,
              //   child:
              //     Align(
              //       alignment: Alignment.centerRight,
              //       child:
              //       Padding(
              //         padding: EdgeInsets.only(right: 75),
              //         child:
              //           Text(
              //           'Λ',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 70,
              //           )
              //         )
              //       )

              //     )

              // )
            ]))),
      );
    });
  }
}
