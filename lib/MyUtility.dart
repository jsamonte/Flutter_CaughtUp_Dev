// This is for launching url in the browser
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';
import './MyFBDocuments.dart' as MyFBDocuments;

// This is to find urls on in the messenger
findUrl(String text) {
  int startIndex = 0;
  int endIndex = 0;

  if (text.contains("https://")) {
    startIndex = text.indexOf("https://");
    endIndex = text.indexOf(" ", startIndex);

    if (endIndex == -1) {
      endIndex = text.length - 1;
    }

    return text.substring(startIndex, endIndex);
  }

  return null;
}

// This launches urls
launchURL(String url) async {
  //  const url = 'https://flutter.io';
  if (url == "") {
    url = 'https://flutter.io';
  }

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Replaces periods with commas
String encodeString(String email) {
  return email.replaceAll(".", ",");
}

// Replaces commas with periods
String decodeString(String email) {
  return email.replaceAll(",", ".");
}

// Converts hours and minutes to an hour double
DateTime convertTimeToDateTime(
    DateTime dayStartDateTime, int currentHourTime, int currentMinutes) {
  Duration specificTimeOfDay =
      Duration(hours: currentHourTime, minutes: currentMinutes);

  return dayStartDateTime.add(specificTimeOfDay);
}

// converts time in hours as double to hours and minutes string
String convertDateTimeToHourMinsDisplay(DateTime timeDateTime) {
  int hours = timeDateTime.hour;
  int minutes = timeDateTime.minute;

  String hoursString;
  String minutesString;

  bool militaryTime = false;

  // If time is in the singles place then add a zero to the end.
  if (minutes < 10) {
    minutes = minutes * 10;
    minutesString = "0" + minutes.toString();
  } else {
    minutesString = minutes.toString();
  }

  // check for 24hour format
  if (militaryTime) {
    // military time format
    hoursString = hours.toString();
    return hoursString + ":" + minutesString;
  } else {
    // not military time (am and pm)
    String amPm;
    if (hours > 12) {
      hours = hours - 12;
      hoursString = hours.toString();
      amPm = " pm";
    } else if (hours < 1) {
      // check to see if hour is 0. if 0 then say 12 am
      hours = 12;
      hoursString = hours.toString();
      amPm = " am";
    } else {
      hoursString = hours.toString();
      amPm = " am";
    }

    return hoursString + ":" + minutesString + amPm;
  }
}

// make sure that the data is from local datetime
String getDateTimeWeekday(DateTime data) {
  String weekday;

  print("WEEKDAY RING: " + data.weekday.toString());

  // weekday (mon, tues, wed
  switch (data.weekday) {
    case 1:
      weekday = "Monday";
      break;
    case 2:
      weekday = "Tuesday";
      break;
    case 3:
      weekday = "Wednesday";
      break;
    case 4:
      weekday = "Thursday";
      break;
    case 5:
      weekday = "Friday";
      break;
    case 6:
      weekday = "Saturday";
      break;
    case 7:
      weekday = "Sunday";
      break;
  }

  return weekday;
}

/// Check if the current user is already friends with a person.
Future<bool> checkIfFriends(
    String friendUid, List<MyFBDocuments.UserFriendItem> _userFriends) async {
  // check if the person is already a friend exist
  if(_userFriends != null){
    for (MyFBDocuments.UserFriendItem friend in _userFriends) {
      print("Debug here User Friends: " + friend.uid);
      if (friendUid == friend.uid) {
        // The user is already friends
        return true;
      }
    }
  }

  // The user is not friends yet
  return false;
}
