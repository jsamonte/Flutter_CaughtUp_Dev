import 'dart:async';

//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart' as MyFBDocuments;
import 'package:flutter_caughtup_dev/Utility/MyFBConstants.dart' as MyFBConstants;

import 'package:intl/intl.dart';

class EventSubDetailPage extends StatefulWidget {
  // Optional Argument passed to "here" final and pass key to the super class
  // here is a state object now defined in MessengerDetailPage
  EventSubDetailPage({
    Key key,
    this.eventDocument,
  }) : super(key: key);

  final MyFBDocuments.EventItem eventDocument;

  // detail screen
  @override
  State createState() => new EventSubDetailPageState();
}

class EventSubDetailPageState extends State<EventSubDetailPage> {

  MyFBDocuments.EventItem eventItem;

  @override
  void initState() {
    // update display data
    setState(() {
      eventItem = widget.eventDocument;

    });
  }

  // Clean up Check clean up on all pages
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
//          padding: new EdgeInsets.all(4.0),
          child:
          new SingleChildScrollView(
              child: new Column(
//              padding: const EdgeInsets.all(16.0),
                        children: <Widget>[
                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
//                    trailing: Icons.email,
//                    tooltip: 'Send e-mail',
//                    onPressed: () {
//                      // analytics logs "ContactDetailPage_sendEmail" to Firebase Analytics
//                      analytics.logEvent(name: 'ContactDetailPage_sendEmail');
//
//                      //remove current snack bar
//                      _scaffoldKey.currentState.removeCurrentSnackBar();
//                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
//                          content: const Text(
//                              'Here, your e-mail application would open.')));
//                    },
                                lines: <String>[
                                  'Title',
                                  eventItem.title,
                                ],
                              ),
                            ],
                          ),

                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
                                lines: <String>[
                                  'Calendar',
                                  eventItem.calendar,
                                ],
                              ),
                            ],
                          ),

                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
                                lines: <String>[
                                  'Activity',
                                  eventItem.activity,
                                ],
                              ),
                            ],
                          ),

                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
                                lines: <String>[
                                  'StartTime',
                                  eventItem.startTime.toIso8601String(),
                                ],
                              ),
                            ],
                          ),

                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
                                lines: <String>[
                                  'EndTime',
                                  eventItem.endTime.toIso8601String(),
                                ],
                              ),
                            ],
                          ),

                          new _InfoCategory(
                            icon: Icons.person,
                            children: <Widget>[
                              new _InfoItem(
                                lines: <String>[
                                  'Note',
                                  eventItem.note,
                                ],
                              ),
                            ],
                          ),
                        ],
                      ))
      );

  }

  /// Converts a double to a time of day.
  TimeOfDay _convertDateTimeToMinHour(DateTime timeToConvert) {
    int hourExtracted = timeToConvert.hour;

    int minExtracted = timeToConvert.minute;

    TimeOfDay extractedTime =
    new TimeOfDay(hour: hourExtracted, minute: minExtracted);

    return extractedTime;
  }

  /// Displays a delete dialog.
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


// TODO this is a repeat and is found at ContactAvailibilityPage
///Displays the icon the of the corresponding activity category.
class _InfoCategory extends StatelessWidget {
  const _InfoCategory({Key key, this.icon, this.children}) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: new BoxDecoration(
            border: new Border(
                bottom: new BorderSide(color: themeData.dividerColor))),
        child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.subhead,
            child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      width: 72.0,
                      child: new Icon(icon, color: themeData.primaryColor)),
                  new Expanded(child: new Column(children: children))
                ])));
  }
}

//TODO this is a repeat and is found at ContactAvailibilityPage
///A contact item which shows a contact.
class _InfoItem extends StatelessWidget {
  _InfoItem(
      {Key key, this.trailing, this.lines, this.tooltip, this.onPressed})
      : assert(lines.length > 1),
        super(key: key);

  final IconData trailing;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final List<Widget> columnChildren = lines
        .sublist(0, lines.length - 1)
        .map((String line) => new Text(line))
        .toList();
    columnChildren
        .add(new Text(lines.last, style: themeData.textTheme.caption));

    final List<Widget> rowChildren = <Widget>[
      new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columnChildren))
    ];
    if (trailing != null) {
      rowChildren.add(new SizedBox(
          width: 72.0,
//          child: trailing));
          child: new IconButton(
              icon: new Icon(trailing),
              color: themeData.primaryColor,
              onPressed: onPressed)));
    }
    return new MergeSemantics(
      child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: rowChildren)),
    );
  }
}

