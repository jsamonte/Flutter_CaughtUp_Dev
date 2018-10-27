

import './MyFBConstants.dart' as MyConstants;

import './MyFBDocuments.dart' as MyFBDocuments;


String encodeTime(double eventStartTime) {
  return eventStartTime.toString().replaceAll(".", ",");
}

double findEventDuration(double startTime, double endTime) {
  return endTime - startTime;
}

//String createGroupChatId() {
//  // createchatID
//  String chatID = allGroupChatsNode.push().key.toString();
//  return chatID;
//}




//class FirebaseEventItem {
//  DateTime startTime;
//  DateTime endTime;
//  String eventActivity;
//  String eventCalendar;
//  String eventNote;
//  String eventId;
//  String groupChatId;
//  String owner;
//
//  FirebaseEventItem(
//      [this.startTime,
//      this.endTime,
//      this.eventActivity,
//      this.eventCalendar,
//      this.eventNote,
//      this.eventId,
//      this.groupChatId,
//      this.owner]);
//}

//// Contact Data
//class ContactItem {
////  final Map<String, double> EventTimeToRemove = {'startTime': null, 'endTime': null};
//  final String fullName;
//  final String timeAvailableStart;
//  final String timeAvailableEnd;
//
//  const ContactItem(
//      {this.fullName, this.timeAvailableStart, this.timeAvailableEnd});
//}
//
//// This is a list of sample contact data
//const KContactItems = const <ContactItem>[
//  const ContactItem(
//      fullName: 'Stephen Tan',
//      timeAvailableStart: '1 pm',
//      timeAvailableEnd: '1 pm'),
//  const ContactItem(
//      fullName: 'Name of a person',
//      timeAvailableStart: '1 pm',
//      timeAvailableEnd: '1 pm')
//];

////////////////////////////////////////////////////////////////////////////////////

//String createUTCTimeFromLocalTime(DateTime UTCdayWithoutTime, double timeToAdd) {
//
//  DateTime localDateTimeWithoutTime = UTCdayWithoutTime.toLocal();
//
//  // add local start time to day to create event id
//  double localStartTimeDouble = timeToAdd;
//  int hours = localStartTimeDouble.toInt();
//  int minutes = ((localStartTimeDouble - hours.toDouble()) * 60).toInt();
//  Duration localStartTimeDuration = new Duration(hours: hours, minutes: minutes);
//
//  // return datetime in utc as milliseconds since epoch
//  return localDateTimeWithoutTime.add(localStartTimeDuration).toUtc().toString();
//}

///////////////////////////////////////////////////////////////////////////////////
// event id

DateTime createNewEventIdFromLocalStartTime(
    DateTime UTCdayWithoutTime, DateTime startTime) {
  DateTime localDateTimeWithoutTime = UTCdayWithoutTime.toLocal();

  // add local start time to day to create event id
  DateTime localStartTimeDouble = startTime;
  int hours = localStartTimeDouble.hour;
  int minutes = localStartTimeDouble.minute;
  Duration localStartTimeDuration =
      new Duration(hours: hours, minutes: minutes);

  // return datetime in utc as milliseconds since epoch
  return localDateTimeWithoutTime.add(localStartTimeDuration).toUtc();
}

DateTime localDateTimeToDateTimeUTC(
    DateTime localDay, DateTime localTimeDouble) {
  int hours = localTimeDouble.hour;
  int minutes = localTimeDouble.minute;

  Duration localStartTimeDuration =
      new Duration(hours: hours, minutes: minutes);

  DateTime utartDateTime = localDay.add(localStartTimeDuration);

  return utartDateTime.toUtc();
}

DateTime convertDateTimeUtcToDateTimeHourMinLocal(DateTime dateTimeUtc) {
  // convert datetime to local datetime
  DateTime localDateTime = dateTimeUtc.toLocal();

//  // extract hours and minutes from date time
//  int hoursTemp = localDateTime.hour;
//  int minutesTemp = localDateTime.minute;
//
//  double hours = hoursTemp.toDouble();
//  double minutes = (minutesTemp.toDouble() / 60);
//
//  double hourMinuteDouble = hours + minutes;

  return localDateTime;
}

DateTime convertStringToDateTime(String stringDateTimeUtc) {
// convert string to datetime
  DateTime utcDateTime = DateTime.parse(stringDateTimeUtc);

  return utcDateTime;
}

String DateTimeToDisplayTime(DateTime inputDateTime) {
  // extract hours and minutes from date time
  int hours = inputDateTime.hour;
  int minutes = inputDateTime.minute;

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
    if (hours >= 12) {
      if (hours != 12) {
        hours = hours - 12;
      }
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
