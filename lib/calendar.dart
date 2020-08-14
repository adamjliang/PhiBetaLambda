import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import './globals.dart' as globals;
import 'package:table_calendar/table_calendar.dart';
import './addEvents.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  
  
  Map<DateTime, List> _pblEvents;
  Map<DateTime, List> _personalEvents;
  Map<DateTime, List> _masterEvents;
  Map<DateTime, List> _emptyEvents;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  bool _pblChecked = true;
  bool _personalChecked = true;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _masterEvents = {
      //DateTime.utc(2020, 7, 9): ['t'],
      //DateTime.utc(2020, 7, 8): ['s'],
    };

    _pblEvents = {
      //DateTime.utc(2020, 7, 8): ['s'],
      // _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0', 'Event A0', 'Event B0', 'Event C0', 'Event A0', 'Event B0', 'Event C0']
      // _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      // _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      
    };
    _personalEvents = {
      //DateTime.utc(2020, 7, 9): ['t'],
      
    };

    _emptyEvents = {};

    _selectedEvents = _pblEvents[_selectedDay] ?? [];
    _calendarController = CalendarController();
    //_calendarController.setSelectedDay(DateTime.now());

    

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    
    setState(() {
      _selectedEvents = events;
      globals.onDay = day;
      globals.events = events;
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
   
  }

  void _onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    final dateTime = DateTime.now();
    _calendarController.setSelectedDay(DateTime(dateTime.year, dateTime.month, dateTime.day),
                  );
  }


  Widget _buildTableCalendar() {
    //final dateTime = DateTime.now();
    //_calendarController.setSelectedDay(dateTime);
    return TableCalendar(
      calendarController: _calendarController,
      events: (_pblChecked && _personalChecked)?_masterEvents:(_pblChecked && !_personalChecked)?_pblEvents:
      (!_pblChecked && _personalChecked)?_personalEvents:_emptyEvents,

      //holidays: _pblEvents,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        
        selectedStyle: TextStyle(color: Colors.yellow[600]),
        weekdayStyle: TextStyle(color: globals.pblblue),
        weekendStyle: TextStyle(color: Colors.yellow[800]),
        selectedColor: globals.pblblue,
        todayColor: Colors.blueAccent[100],
        todayStyle: TextStyle(color: globals.pblblue),
        markersColor: globals.logoyellowdarker,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        //titleTextStyle: TextStyle(color: globals.pblblue),
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: globals.pblblue,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  /*Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'pl_PL',
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }
*/
 /* Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
*/
  /*Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
*/
  Widget _buildButtons() {
    final dateTime = DateTime.now();
    

    return Column(
      children: <Widget>[
        
        RaisedButton(
          child: Text('Refresh Calendar'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList(AsyncSnapshot<dynamic> document) {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () {
                    _showAlert(context, event, document);
                    print('$event tapped!');
                    // AlertDialog(

                    // );
                  }
                ),
              ))
          .toList(),
    );
  }

    _showAlert(BuildContext context, dynamic event, AsyncSnapshot<dynamic> snapshot){
      int useThisI = -1;
      for (int i = 0; i < snapshot.data.documents.length; i++){
        if (event.toString() == snapshot.data.documents[i]['Title']){
          useThisI = i;
        }
      }
    // set up the buttons
  Widget editButton = FlatButton(
    child: Text("Edit"),
    onPressed:  (){
      Navigator.pop(context);
    },
  );
  Widget deleteButton = FlatButton(
    child: Text("Delete"),
    onPressed:  () {
      print(useThisI);
      _showDeleteAlert(context, useThisI, snapshot);
      // if (globals.deleteCalEvent){
      //   Firestore.instance.collection("Calendar").document('$useThisI').delete();
      //   globals.deleteCalEvent = false;
      // }
      //Navigator.pop(context);
    },
  );
  Widget doneButton = FlatButton(
    child: Text("Done"),
    onPressed:  (){
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  int calType = snapshot.data.documents[useThisI]['Calendar Choice'];
  String calTypeS;
  (calType == 0)?calTypeS = "Personal":calTypeS = "PBL";
  AlertDialog alert = AlertDialog(
    title: Text("$event"),
    content: (snapshot.data.documents[useThisI]['Dress Code'] == 'N/A' && snapshot.data.documents[useThisI]['Location'] == 'N/A')?
    Text('${snapshot.data.documents[useThisI]['Print Start Date']} - ${snapshot.data.documents[useThisI]['Print End Date']}\n\nCalendar Type: $calTypeS'):
    (snapshot.data.documents[useThisI]['Dress Code'] != 'N/A' && snapshot.data.documents[useThisI]['Location'] == 'N/A')?
    Text('${snapshot.data.documents[useThisI]['Print Start Date']} - ${snapshot.data.documents[useThisI]['Print End Date']} \n\nDress Code: ${snapshot.data.documents[useThisI]['Dress Code']}\n\nCalendar Type: $calTypeS'):
    (snapshot.data.documents[useThisI]['Dress Code'] == 'N/A' && snapshot.data.documents[useThisI]['Location'] != 'N/A')?
    Text('${snapshot.data.documents[useThisI]['Print Start Date']} - ${snapshot.data.documents[useThisI]['Print End Date']} \n\nLocation: ${snapshot.data.documents[useThisI]['Location']}\n\nCalendar Type: $calTypeS'):
    Text('${snapshot.data.documents[useThisI]['Print Start Date']} - ${snapshot.data.documents[useThisI]['Print End Date']} \n\nLocation: ${snapshot.data.documents[useThisI]['Location']} \n\nDress Code: ${snapshot.data.documents[useThisI]['Dress Code']}\n\nCalendar Type: $calTypeS')
    ,actions: [
      (globals.level > 1 || snapshot.data.documents[useThisI]['Calendar Choice'] < 1)?editButton:null,
      (globals.level > 1 || snapshot.data.documents[useThisI]['Calendar Choice'] < 1)?deleteButton:null,
      doneButton
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
 
  _showDeleteAlert(BuildContext context, int useThisI, AsyncSnapshot<dynamic> snapshot){
    // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed:  (){
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed:  () {
      //globals.deleteCalEvent = true;
      //Firestore.instance.collection("Usernames").document(document["Username"].toString()).delete();
      setState(() {
        print('got here');
        DateTime _selectedDay = globals.onDay;
        print(_selectedDay.toString());
        _selectedEvents = globals.events;
        // if (snapshot.data.documents[useThisI]['Calendar Choice'] == 0){
        //   DateTime keyTime = DateTime.now();
        //   if (_personalEvents.containsKey(keyTime)){
        //     _personalEvents[keyTime].add(snapshot.data.documents[useThisI]['Entry']);
        //   }
        //   else{
        //     _personalEvents[keyTime] = [snapshot.data.documents[useThisI]['Entry']];
        //   }
        //   if (_masterEvents.containsKey(keyTime)){
        //           _masterEvents[keyTime].add(snapshot.data.documents[useThisI]['Entry']);
        //         }
        //         else{
        //           _masterEvents[keyTime] = [snapshot.data.documents[useThisI]['Entry']];
        //         }
        // }
      });
      Firestore.instance.collection("Calendar").document('${snapshot.data.documents[useThisI]['Entry']}').delete();
      
      // setState(() {
      //   final dateTime = DateTime.now().subtract(Duration(days: 1));
      //             _calendarController.setSelectedDay(
      //             DateTime(dateTime.year, dateTime.month, dateTime.day),
      //             runCallback: true,
      //       );
      // });
      
      Navigator.pop(context);
      Navigator.pop(context);
      
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text('Are you sure you want to delete this event?'),
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
      
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
        
      //   onPressed: (){
      //     Navigator.push(context, new MaterialPageRoute(
      //       builder: (BuildContext context) => new AddEventsPage()),
      //     );
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 75,
          child: 
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 75,
                  width: 165,
                  child: 
                    CheckboxListTile(
                      onChanged: (bool value){
                        setState(() {
                          _pblChecked = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'PBL Calendar',
                        
                        style: TextStyle(
                          fontSize: 18,
                        )
                      ),
                      value: _pblChecked,
                    ),
                ),
                  Container(
                  height: 75,
                  width: 165,
                  child: 
                    CheckboxListTile(
                      onChanged: (bool value){
                        setState(() {
                          _personalChecked = value;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'My Calendar',
                        
                        style: TextStyle(
                          fontSize: 18,
                        )
                      ),
                      value: _personalChecked,
                    ),
                ),
                
              
              ]

          )
        ),
      ),
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: globals.pblblue,
        title: new Text('Calendar'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) => new AddEventsPage()),
              ).then((value) {
                setState(() {
                  final dateTime = DateTime.now();
                  _calendarController.setSelectedDay(
                  DateTime(dateTime.year, dateTime.month, dateTime.day),
                  runCallback: true,
            );
                });
               });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Calendar').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          
          //clear event list
          _masterEvents.clear();
          _personalEvents.clear();
          _pblEvents.clear();

          //DateTime test = DateTime.utc(2020, 07, 27);
          if (snapshot.data.documents.length > 1){
            
            for (int i = 0; i < snapshot.data.documents.length - 1; i++){
              DateTime keyTime = DateTime.utc(int.parse(snapshot.data.documents[i]['Start'].toString().substring(0,4)),
              int.parse(snapshot.data.documents[i]['Start'].toString().substring(5,7)),
              int.parse(snapshot.data.documents[i]['Start'].toString().substring(8,10)));
              

              if (snapshot.data.documents[i]['Calendar Choice'] == 0){
                if (snapshot.data.documents[i]['Username'] == globals.username){
                  if (_personalEvents.containsKey(keyTime)){
                    _personalEvents[keyTime].add(snapshot.data.documents[i]['Title']);
                  }
                  else{
                    _personalEvents[keyTime] = [snapshot.data.documents[i]['Title']];
                  }
                  if (_masterEvents.containsKey(keyTime)){
                    _masterEvents[keyTime].add(snapshot.data.documents[i]['Title']);
                  }
                  else{
                    _masterEvents[keyTime] = [snapshot.data.documents[i]['Title']];
                  }
                }
                
              }
              else{
                if (_pblEvents.containsKey(keyTime)){
                  _pblEvents[keyTime].add(snapshot.data.documents[i]['Title']);
                }
                else{
                  _pblEvents[keyTime] = [snapshot.data.documents[i]['Title']];
                }
                if (_masterEvents.containsKey(keyTime)){
                  _masterEvents[keyTime].add(snapshot.data.documents[i]['Title']);
                }
                else{
                  _masterEvents[keyTime] = [snapshot.data.documents[i]['Title']];
                }
              }
            }
          }


          


          
          //_pblEvents[test] = ['food'];
          //_pblEvents[test].add(['value']);

          //_masterEvents[test] = ['food'];
          //_masterEvents[test].add(['value']);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
            _buildTableCalendar(),
             //_buildTableCalendarWithBuilders(),
              const SizedBox(height: 8.0),
              _buildButtons(),
              const SizedBox(height: 8.0),
              Expanded(child: _buildEventList(snapshot)),
            ],
          );
        }
      )
    );
  }
}