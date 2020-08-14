import 'package:flutter/material.dart';

const pblblue = const Color(0xff003366);

const logoyellow = const Color(0xfffcd972);
const logoyellowdarker = const Color(0xfffcd172);
const aform = "https://docs.google.com/forms/d/e/1FAIpQLSeMTajkamXgRKlAuFfsCiBDAmWrN95LOz33hBnQ7v4Vk4wt4Q/viewform";
const websiteurl = "https://www.pblumich.com";
const rushurl = "https://www.pblumich.com/rush";
const calendarurl = "https://calendar.google.com/calendar/r";
const databaseurl = "https://docs.google.com/spreadsheets/d/1J90WfvB44zIUKJKMa20Gkhcys3Dl-KzUY5ON4zMJXsg/edit#gid=0";

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