
import 'package:flutter/material.dart';

import './CalSubScheduleView.dart' as CalSubScheduleView;

// Opened Calendar View Navigation Drawer
class CalMainNavigationDrawer extends StatefulWidget {
  CalMainNavigationDrawer({Key key})
      : super(key: key);

//  final DocumentSnapshot personInformationDocument;

  static const String routeName = "CalMainNavigationDrawer";

  @override
  CalMainNavigationDrawerState createState() =>
      new CalMainNavigationDrawerState();
}

class CalMainNavigationDrawerState extends State<CalMainNavigationDrawer> {
  // determines which navigation drawer item was selected.
  int _selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calendar InDev"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            tooltip: 'Exit',
            onPressed: () {
              Navigator.pop(context);
            }, //
          ),
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(
                color: Colors.orange,
              ),
            ),
            new ListTile(
              title: new Text('Schedule'),
              onTap: () {
                // Update Fragment
                setState(() {
                  _selectedDrawerIndex = 0;
                });
                // Close Navigation Drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Day'),
              onTap: () {
                // Update Fragment
                setState(() {
                  _selectedDrawerIndex = 1;
                });
                // Close Navigation Drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Week'),
              onTap: () {
                // Update Fragment
                setState(() {
                  _selectedDrawerIndex = 2;
                });
                // Close Navigation Drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Month'),
              onTap: () {
                // Update Fragment
                setState(() {
                  _selectedDrawerIndex = 3;
                });
                // Close Navigation Drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: new Icon(Icons.add),
        onPressed: () {
//          DateTime nowUTC = new DateTime.now();
//
//          Duration oneday = new Duration(days: 1);

          // todo add calendar event
        },
      ),
    );
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        // Schedule View
        return new CalSubScheduleView.CalSubScheduleView();
      case 1:
        // Day View
        return new Container(
          child: new Center(child: new Text('Day View')),
        );
      case 2:
        // Week View
        return new Container(
          child: new Center(child: new Text('Week View')),
        );
      case 3:
        // Month View
        return new Container(
          child: new Center(child: new Text('Month View')),
        );

      default:
        return new Container(
          child: new Center(child: new Text('Error')),
        );
    }
  }
}
