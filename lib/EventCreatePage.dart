import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_caughtup_dev/Utility/MyUtility.dart' as MyUtility;
import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart' as MyFBDocuments;
import 'package:flutter_caughtup_dev/Utility/MyFBConstants.dart' as MyFBConstants;
import './CalSubScheduleView.dart' as CalSubScheduleView;
import 'package:flutter_caughtup_dev/Utility/MyScheduleFirebaseUtility.dart' as MyScheduleFirebaseUtility;
import 'package:intl/intl.dart';

// user message to send as part of the hangout invite
String sendUserEventEventMessage;
String sendUserEventGroupID;
String sendGroupName;
String sendActivityName;

// pass to subEventAvailablePage.dart
DateTime passOriginalLocalDateTimeInView;

DateTime _fromDate = new DateTime.now();
TimeOfDay fromTime = new TimeOfDay(hour: 0, minute: 0);
DateTime _toDate = new DateTime.now();
TimeOfDay endTime = new TimeOfDay(hour: 0, minute: 0);

class EventCreatePage extends StatefulWidget {
  // Optional Argument passed to "here" final and pass key to the super class
  // here is a state object now defined in MessengerDetailPage
  EventCreatePage({
    Key key,
    this.eventDocument,
  }) : super(key: key);

  final MyFBDocuments.EventItem eventDocument;

  // detail screen
  @override
  State createState() => new EventCreatePageState();
}

class EventCreatePageState extends State<EventCreatePage> {
  // This is note field textController
  TextEditingController _noteFieldTextController;

  // so save note button only works when textfield was changed
  bool _isComposing = false;

  String _note = "";

  // chosen activity
  String _activity = MyFBConstants.Hangout3;

  // chosen calendar item
  String _calendar = MyFBConstants.FreeTimeCalendar3;

  final List<String> _allActivities = <String>[
    MyFBConstants.Hangout3,
    MyFBConstants.Eat3,
    MyFBConstants.Exercise3,
    MyFBConstants.NotSure3
  ];

  final List<String> _allCalendars = <String>[
    MyFBConstants.FreeTimeCalendar3,
    MyFBConstants.PrivateCalendar3,
    MyFBConstants.ClassCalendar3,
  ];

  @override
  void initState() {
    // update display data
    setState(() {
      _activity = widget.eventDocument.activity;

      // todo set to calendar from
      _calendar = widget.eventDocument.calendar;

      // todo change to event start date
      _fromDate = widget.eventDocument.startTime;

      // extract the hours and minutes from double
      fromTime = _convertDateTimeToMinHour(widget.eventDocument.startTime);

      //todo change to event end date
      _toDate = widget.eventDocument.endTime; //new DateTime.now();

      // extract the hours and minutes from double
      endTime = _convertDateTimeToMinHour(widget.eventDocument.endTime);

      _note = widget.eventDocument.note;

      // initialize noteTextfield Controller
      _noteFieldTextController = new TextEditingController(text: _note);

      sendUserEventGroupID = widget.eventDocument.groupID;

      sendGroupName = widget.eventDocument.title;
//      _fromTime.hour.toString() + ":" + _fromTime.minute.toString();

      sendActivityName = _activity;
    });

    String noteToAdd = "";

    if (_note != "") {
      noteToAdd = "\n" + _note;
    }

    // update SendUserEventMessage
    _updateEventMessageForInvite();
  }

  // Clean up Check clean up on all pages
  @override
  void dispose() {
    _noteFieldTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child:
          new SingleChildScrollView(

          child: new DropdownButtonHideUnderline(


          child: new Column(
            children: <Widget>[
              new Container(

                child: new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Calendar',
                    hintText: 'Choose a calendar',
                  ),
                  isEmpty: widget.eventDocument.activity == null,
                  child: new DropdownButton<String>(
                    value: _calendar,
                    isDense: true,
                    onChanged: (String newValue) {
                      // update selected time indatabase
                      if (_updateEventInformationInFirebase(context,
                          eventID: widget.eventDocument.documentID,
                          eventGroupChatId: widget.eventDocument.groupID,
                          endTime: endTime,
                          eventActivity: widget.eventDocument.activity,
                          eventCalendar: newValue,
                          eventNote: _note)) {
                        // if data is updated in database then update the view with new data
                        setState(() {
                          // update in ScheduleTimeDetail
                          _calendar = newValue;
                          // update list in subSchedulePage with the new event
//                                _updateSubSchedulePageInfoAndInviteMessage(
//                                    widget.userDayEventDataList);
                        });
                      }
                    },
                    items: _allCalendars.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Container(
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                padding: new EdgeInsets.only(right: 8.0),
                                child: new CalendarIcon(value),
                              ),
                              new Text(value),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
                    new Container(
                      child: new InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Activity',
                          hintText: 'Choose an activity',
                        ),
                        isEmpty: widget.eventDocument.activity == null,
                        child: new DropdownButton<String>(
                          value: _activity,
                          isDense: true,
                          onChanged: (String newValue) {
                            // notify the user that there is new data to save
                          },
                          items: _allActivities.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Container(
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      padding: new EdgeInsets.only(right: 8.0),
                                      child: new ActivityIcon(value),
                                    ),
                                    new Text(value),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              new _DateTimePicker(
                labelText: 'From',
                selectedDate: _fromDate,
                selectedTime: fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    fromTime = time;
                  });
                },
              ),
              new _DateTimePicker(
                labelText: 'EndTime',
                selectedDate: _toDate,
                selectedTime: endTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _toDate = date;
                  });
                },
                selectTime: (TimeOfDay newEndTime) {
                  // update selected time indatabase
                  if (_updateEventInformationInFirebase(context,
                      eventID: widget.eventDocument.documentID,
                      eventGroupChatId: widget.eventDocument.groupID,
                      endTime: newEndTime,
                      eventActivity: _activity,
                      eventNote: _note)) {
                    // if data is updated in database then update the view with new data
                    setState(() {
                      // update in ScheduleTimeDetail
                      endTime = newEndTime;

                      // update list in subSchedulePage with the new event
//                            _updateSubSchedulePageInfoAndInviteMessage(
////                                  widget.onEventChanged,
//                                widget.userDayEventDataList);
                    });
                  }
                },
              ),
//                    new TextField(
//                      decoration: const InputDecoration(
//                        labelText: 'Location',
//                      ),
//                      style: Theme
//                          .of(context)
//                          .textTheme
//                          .display1
//                          .copyWith(fontSize: 20.0),
//                    ),
              new Container(
//                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new TextField(
                        autofocus: false,
                        maxLength: 50,
                        maxLines: 1,
//                        keyboardType: TextInputType.multiline,
                        controller: _noteFieldTextController,
                        // Prevents using send button when there is no search text typed
                        onChanged: (String text) {
                          setState(() {
                            // so user can only click on save when contents of the note were changed
                            _isComposing = text != _note;
                          });
                        },
                        // I don't know why I dont pass in a string to "_handlesSubmitted here... but it works
                        onSubmitted: (_isComposing)
                            ? _handleNoteTextfieldSubmitted
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Note:',
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .copyWith(fontSize: 20.0),
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 4.0),
                      child: new IconButton(
                          icon: new Icon(Icons.save),

                          // Prevents using send button when there is no search text typed
                          onPressed: _isComposing
                              ? () => _handleNoteTextfieldSubmitted(
                              _noteFieldTextController.text)
                              : null),
                    ),
                  ],
                ),
              ),
              new Container(
//                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: new Row(
                    children: <Widget>[
                      new FlatButton(
                        color: Colors.orange,
                        onPressed: () {
                          print('MyButton was tapped!');

                          // display still in development snackbar

                        },
                        child: new Container(
                          child: new Text("Does not Repeat"),
                        ),
                      )
                    ],
                  )),
            ],
          )))
      ),
    );

  }

  /// Handles submitting search item
  Future<Null> _handleNoteTextfieldSubmitted(String text) async {
    if (text != null) {
      // update selected time in database
      if (_updateEventInformationInFirebase(context,
          eventID: widget.eventDocument.documentID,
          eventGroupChatId: widget.eventDocument.groupID,
          endTime: endTime,
          eventActivity: _activity,
          eventNote: text)) {
        // if data is updated in database then update the view with new data
        setState(() {
          // update in ScheduleTimeDetail
          _note = text;
          // update list in subSchedulePage with the new event
//          _updateSubSchedulePageInfoAndInviteMessage(
////              widget.onEventChanged,
//              widget.userDayEventDataList);
        });
      }
    }

    // Prevents using send button when there is no search text typed
    setState(() {
      _isComposing = false;
    });
  }
  /// Converts a double to a time of day.
  TimeOfDay _convertDateTimeToMinHour(DateTime timeToConvert) {
    int hourExtracted = timeToConvert.hour;

    int minExtracted = timeToConvert.minute;

    TimeOfDay extractedTime =
        new TimeOfDay(hour: hourExtracted, minute: minExtracted);

    return extractedTime;
  }

  /**
   * Displays a delete dialog.
   */
  void showDeleteDialog(BuildContext mContext, String openTime) {

    var alert = new AlertDialog(
      title: new Text("Delete this event?"),
      content: new Container(
//        padding: const EdgeInsets.all(10.0),
        child: new Text(
            "This will also delete the group chat."), // new Icon(Icons.delete),
      ),
      actions: <Widget>[
        new RaisedButton(
          child: const Text('No'),
          onPressed: () {
            // close view
            Navigator.pop(mContext); // dismiss dialog
          },
        ),
        new RaisedButton(
          child: const Text('Yes'),
          onPressed: () {
            // close dialog and closes ScheduleTimeDetail view

          },
        ),
      ],
    );

    showDialog(context: mContext, child: alert);
  }

  /// Updates event informaiton in the database.
  bool _updateEventInformationInFirebase(BuildContext context,
      {String eventID,
      String eventGroupChatId,
      TimeOfDay endTime,
      String eventActivity,
      String eventCalendar,
      String eventNote}) {
    DateTime startTimeDateTime = MyUtility.convertTimeToDateTime(
        passOriginalLocalDateTimeInView.toUtc(),
        fromTime.hour,
        fromTime.minute);

    DateTime endTimeDateTime = MyUtility.convertTimeToDateTime(
        passOriginalLocalDateTimeInView.toUtc(), endTime.hour, endTime.minute);

    bool updatingEventStatus = false;

    String messageAboutSaveSuccess = "Unknown";

    // fifteen minute duration
    Duration fifteenMinDuration = Duration(minutes: 15);

    // checks for time conflicts
    if (endTimeDateTime.compareTo(startTimeDateTime.add(fifteenMinDuration)) <
        0) {
      // Check if the end time is before the startTime
      // The time selected is before the start time

      messageAboutSaveSuccess = "Sorry, An event must be atleast 15 minutes.";

      updatingEventStatus = false; // event will not be updated in database

    } else if (!_checkForConflicts(CalSubScheduleView.allUserEventsDataList,
        startTimeDateTime, endTimeDateTime)) {
      // check for time conflicts
      // there was no conflict

      // update database
//      // Create New Event In database
//      MyScheduleFirebaseUtility.createEventInFirebase(
//          eventStartTime: startTimeDateTime,
//          eventEndTime: endTimeDateTime,
//          eventActivity: eventActivity,
//          eventCalendar: eventCalendar,
//          eventNote: eventNote,
//          owner: MyAuthentication.authenticatedUser.uid);

      // todo listen for update success

      // todo listen for delete success

      updatingEventStatus = true; // event is being updated in the database

      messageAboutSaveSuccess = "Event sucessfully updated.";
    } else {
      // there is a time conflict

      messageAboutSaveSuccess = "There's a conflict.";

      updatingEventStatus = false; // event will not be updated in database
    }

    return updatingEventStatus;
  }

  /// Checks for time conflics with previous events.
  bool _checkForConflicts(List<MyFBDocuments.EventItem> userEventDataList,
      DateTime eventStartTime, DateTime eventEndTime) {
    // Check if there are time conflicts with other events
    for (int i = 0; i < userEventDataList.length; i++) {
      // don't check for time conflicts against the event being moved.
      if (eventStartTime != MyScheduleFirebaseUtility.convertDateTimeUtcToDateTimeHourMinLocal(
              userEventDataList[i].startTime)) {
        if (eventStartTime.compareTo(MyScheduleFirebaseUtility
                    .convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].startTime)) >
                0 &&
            eventStartTime.compareTo(MyScheduleFirebaseUtility
                    .convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].endTime)) <
                0) {
          // end time is within other events
          return true; // there is a conflict

        } else if (eventEndTime.compareTo(MyScheduleFirebaseUtility
                    .convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].startTime)) >
                0 &&
            eventEndTime.compareTo(MyScheduleFirebaseUtility
                    .convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].endTime)) <
                0) {
          // end time is not within other events
          return true; // there is a conflict

          // check if other events are inside event being edited
        } else if ((MyScheduleFirebaseUtility
                        .convertDateTimeUtcToDateTimeHourMinLocal(
                            userEventDataList[i].startTime))
                    .compareTo(eventStartTime) >
                0 &&
            (MyScheduleFirebaseUtility.convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].startTime))
                    .compareTo(eventEndTime) <
                0) {
          // other event startTime is within currentEvent
          return true;

          // check if other events are inside event being edited
        } else if ((MyScheduleFirebaseUtility
                        .convertDateTimeUtcToDateTimeHourMinLocal(
                            userEventDataList[i].endTime))
                    .compareTo(eventStartTime) >
                0 &&
            (MyScheduleFirebaseUtility.convertDateTimeUtcToDateTimeHourMinLocal(
                        userEventDataList[i].endTime))
                    .compareTo(eventEndTime) <
                0) {
          // other event endTime is within currentEvent
          return true;
        }
      }
    }

    // there is no time conflict
    return false;
  }

  /**
   * Updates page with new information.
   */
//  void _updateSubSchedulePageInfoAndInviteMessage(
////      PageSelectorSubSchedulePageContent.EventChangedCallback onEventChanged,
//      List UserEventDataList) {
////    onEventChanged;
//
//    _updateEventMessageForInvite();
//
//    // This should be called inside a setstate Function to work/update the view
//
//    // update list in subSchedulePage with the new event
//    UserEventDataList[widget.OriginalEventIndex] = {
//      MyConstants.eventId2: widget.OriginalEventId,
//      MyConstants.groupChatID2: widget.OriginalEventGroupId,
//      MyConstants.eventActivity2: _activity,
//      MyConstants.eventCalendar2: _calendar,
//      MyConstants.startTime2:
//          MyScheduleFirebaseUtility.localDateTimeToDateTimeUTC(
//              widget.OriginalLocalDateTimeInView,
//              MyUtility.convertTimeToDateTime(PassOriginalLocalDateTimeInView, fromTime.hour, fromTime.minute)),
//      MyConstants.endTime2:
//          MyScheduleFirebaseUtility.localDateTimeToDateTimeUTC(
//              widget.OriginalLocalDateTimeInView,
//              MyUtility.convertTimeToDateTime(PassOriginalLocalDateTimeInView, endTime.hour, endTime.minute)),
//      MyConstants.eventNote2: _Note,
//    };
//  }

  /// Converts time of day to a string.
  String _timeOfDayToReadableString(TimeOfDay time) {
    String minutes;
    if (time.minute < 10) {
      minutes = "0" + time.minute.toString();
    } else {
      minutes = time.minute.toString();
    }

    return time.hour.toString() + ":" + minutes;
  }

  /// Updates string message for the invite message.
  void _updateEventMessageForInvite() {
    String noteToAdd = "";

    sendActivityName = _activity;

    if (_note != "") {
      noteToAdd = "\n" + _note;
    }

    // todo update send message
    sendUserEventEventMessage = "HI";
//    SendUserEventEventMessage = "Date: " +
//        SendGroupName +
//        "\nTime: " +
//        _timeOfDayToReadableString(fromTime) +
////        " - " +
//        _timeOfDayToReadableString(endTime) +
//        noteToAdd;
  }

}

/// The activity icon to display.
class ActivityIcon extends StatelessWidget {
  ActivityIcon(this.value);

  final String value;
  Icon iconReturn;

  @override
  Widget build(BuildContext context) {
    switch (value) {
      case MyFBConstants.Hangout3:
        iconReturn = new Icon(Icons.group);
        break;
      case MyFBConstants.Eat3:
        iconReturn = new Icon(Icons.restaurant);
        break;
      case MyFBConstants.Exercise3:
        iconReturn = new Icon(Icons.directions_run);
        break;
      case MyFBConstants.NotSure3:
        iconReturn = new Icon(Icons.nature_people);
        break;
    }
    return iconReturn;
  }
}

/// Calendar icon to display.
class CalendarIcon extends StatelessWidget {
  CalendarIcon(this.value);

  final String value;
  Icon iconReturn;

  @override
  Widget build(BuildContext context) {
    switch (value) {
      case MyFBConstants.FreeTimeCalendar3:
        iconReturn = new Icon(Icons.sentiment_very_satisfied);
        break;
      case MyFBConstants.PrivateCalendar3:
        iconReturn = new Icon(Icons.lock);
        break;
      case MyFBConstants.ClassCalendar3:
        iconReturn = new Icon(Icons.school);
        break;
    }
    return iconReturn;
  }
}

/// The date picker for the to and for date selection.
class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body2;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 5,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMMEEEEd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

/// Theme component for the date picker.
class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
