
import 'package:flutter/material.dart';

import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart' as MyFBDocuments;
import './EventSubDetailPage.dart' as EventSubDetailPage;
import './EventSubAvailablePage.dart' as EventSubAvailablePage;


/// A global key to find its own Scaffold for the AppBar's action.
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

/// The event view tab which shows event details.
class EventTabView extends StatefulWidget {
  // Optional Argument passed to "here" final and pass key to the super class
  // here is a state object now defined in MessengerDetailPage
  EventTabView({Key key, this.OpenEventDocument}) : super(key: key);

  static const routeName = "/EventTabView";

  final MyFBDocuments.EventItem OpenEventDocument;

  @override
  _EventTabViewState createState() => new _EventTabViewState();
}

/// The event view tab state.
class _EventTabViewState extends State<EventTabView> {
  @override
  void initState() {
    choices = <Choice>[
      new Choice(
          title: 'Event',
          icon: Icons.directions_car,
          page: new EventSubDetailPage.EventSubDetailPage(
              eventDocument: widget.OpenEventDocument)),
      new Choice(
          title: 'Available',
          icon: Icons.directions_car,
          page: new EventSubAvailablePage.EventSubAvailablePage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: choices.length,
      child: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text(widget.OpenEventDocument.title),
          actions: <Widget>[
            new PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                onSelected: showMenuSelection,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          value: 'Members',
                          child: const ListTile(
                              leading: const Icon(Icons.people),
                              title: const Text('Members (in Dev)'))),
                      const PopupMenuDivider(),
                      // ignore: list_element_type_not_assignable, https://github.com/flutter/flutter/issues/5771
                      const PopupMenuItem<String>(
                          value: 'Group Message',
                          child: const ListTile(
                              leading: const Icon(Icons.message),
                              title: const Text('Group Message (in Dev)'))),
                      const PopupMenuDivider(),
                      // ignore: list_element_type_not_assignable, https://github.com/flutter/flutter/issues/5771
                      const PopupMenuItem<String>(
                          value: 'Delete Event',
                          child: const ListTile(
                              leading: const Icon(Icons.delete),
                              title: const Text('Delete Event')))
                    ]),
          ],
          bottom: new TabBar(
            isScrollable: false,
            tabs: choices.map((Choice choice) {
              return new Tab(
                text: choice.title,
//                  icon: new Icon(choice.icon),
              );
            }).toList(),
          ),
        ),
        body: new TabBarView(
          children: choices.map((Choice choice) {
            return new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new ChoiceCard(choice: choice),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// App bar action selection.
  void showMenuSelection(String value) {
    switch (value) {
      case "Members":

        // open group members page

//        // Set variables to pass to GroupMembersPage
//        MyVariables.chatIDForDetail = widget.OpenEventDocument[MyConstants.groupChatID2];
//
//        // todo auto update group chat name when activity is updated
//        MyVariables.chatNameForDetail = widget.OpenEventDocument[MyConstants.eventActivity2];



        // Navigate to group members page
//        Navigator.of(context).pushNamed("/GroupMembersPage");
        break;
      case "Group Message":

        // Open group Message DetailPage

        // pass variables needed by messengerDetailPage.dart
//        // information to pass to MessengerDetailPage
//        MyVariables.chatIDForDetail = widget.OpenEventDocument[MyConstants.groupChatID2];
//        // this is the group name or the recipient name
//        MyVariables.chatNameForDetail = widget.OpenEventDocument[MyConstants.eventTitle2];
//        // notify MessengerDetailPage.dart if I am opening a group chat or a direct chat
//        MyVariables.openingGroupMessenger = true;

        // Navigate to MessengerDetailPage
//        Navigator.of(context).pushNamed("/MessengerDetailPage");
        break;
      case "Delete Event":

        // Confirm event delete
        _showDeleteDialog(context, widget.OpenEventDocument.documentID);
        break;
      default:
      // todo notify user that there was an error
    }
  }

  /// Private detete event dialog.
  void _showDeleteDialog(BuildContext mContext, String openTime) {

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
////            Navigator.pop(mContext); // dismiss dialog
//            Navigator.popUntil(
//                context,
//                ModalRoute.withName(
//                    CalMainNavigationDrawer.CalMainNavigationDrawer.routeName));
          },
        ),
      ],
    );

    showDialog(context: mContext, child: alert);
  }
}

/// possible choices in the tabbar view.
List<Choice> choices;

/// List item choice with icon.
class Choice {
  Choice({this.title, this.icon, this.page});

  final String title;
  final IconData icon;
  final Widget page;
}

/// Choice card for choices.
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
//    return new Card(
//      color: Colors.white,
//      child: new Center(
//        child: new Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            new Icon(choice.icon, size: 128.0, color: textStyle.color),
//            new Text(choice.title, style: textStyle),
//          ],
//        ),
//      ),
//    );
    return choice.page;
  }
}
