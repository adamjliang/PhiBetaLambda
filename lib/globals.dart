import 'package:flutter/material.dart';
//import 'dart:io';

const pblblue = const Color(0xff003366);

const logoyellow = const Color(0xfffcd972);
const logoyellowdarker = const Color(0xfffcd172);
const aform =
    "https://docs.google.com/forms/d/e/1FAIpQLSeMTajkamXgRKlAuFfsCiBDAmWrN95LOz33hBnQ7v4Vk4wt4Q/viewform";
const websiteurl = "https://www.pblumich.com";
const rushurl = "https://www.pblumich.com/rush";
const calendarurl = "https://calendar.google.com/calendar/r";
const databaseurl =
    "https://docs.google.com/spreadsheets/d/1J90WfvB44zIUKJKMa20Gkhcys3Dl-KzUY5ON4zMJXsg/edit#gid=0";

const zoomurl = "https://umich.zoom.us/j/94024784486";

bool logged = false;
String inputUsername;
String inputPassword;
String firstName;
String lastName;
String usernameLogged;
int level;
String username;

bool refreshLogin = false;

bool hasErrorLogin = false;

String changedText;

bool deleteCalEvent = false;

DateTime onDay;
List<dynamic> events;

bool reloadCal = true;

String viewFirstName;
String viewLastName;
String viewBirthday;
String viewMajor;
String viewPhoneNumber;
String viewYear;
String viewUsername;

var testingStuff;

//File userProfilePicture;
//String profileurl = 'https://firebasestorage.googleapis.com/v0/b/phi-beta-lambda-calendar.appspot.com/o/uploads%2FFile%3A%20\'%2FUsers%2Fadamliang%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2FCF449B6A-2D5A-4D18-96ED-914F2E9DFA12%2Fdata%2FContainers%2FData%2FApplication%2F03D91332-AD26-4C98-9ED5-5E2BDC8108FD%2Ftmp%2Fdefault_profile_pic.jpg?alt=media&token=0ac5b69a-b2e9-4e77-9143-2bd26b08c449';
String profileurl;
bool globalChangePicture = false;

bool isVoteSwitched = false;
bool isChangeSwitched = false;

List<String> gFriendsList = [null];

bool firstSwitch = false;
bool secondSwitch = false;
bool thirdSwitch = false;
bool fourthSwitch = false;
bool fifthSwitch = false;
bool sixthSwitch = false;
bool seventhSwitch = false;
bool eighthSwitch = false;
bool ninthSwitch = false;
bool tenthSwitch = false;

String currentEventTitle;
String currentCheckInEventTitle;
