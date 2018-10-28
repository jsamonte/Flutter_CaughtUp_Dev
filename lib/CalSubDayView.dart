import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

import 'package:flutter_caughtup_dev/Utility/FakeData.dart' as FakeData;
import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart' as MyFBDocuments;

import './EventTabView.dart' as EventTabView;

// This is a list of all user events
List<MyFBDocuments.EventItem> allUserEventsDataList = new List();

/// Contact Detail Page which displays information on a person.
class CalSubDayView extends StatefulWidget {
//  static const String routeName = '/contacts';
// here is a state object now defined in MessengerDetailPage
  CalSubDayView({Key key})
      : super(key: key);

//  final DocumentSnapshot personInformationDocument;

  @override
  CalSubScheduleViewPageState createState() =>
      new CalSubScheduleViewPageState();
}

/// Contact Detail page state.
class CalSubScheduleViewPageState extends State<CalSubDayView> {
  final TextEditingController _textController = new TextEditingController();

  // so search button only works when text field is not empty
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      allUserEventsDataList = new List();

      // initialize text controller
      _textController.clear();

      print("test text here: " + _textController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

//    // remove stream listener
//    documentRef.cancel();

    // remove text controller
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Container(
        margin: new EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 10.0,
        ),
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new Text('The Default Calendar:'),
//            new Calendar(
//              onSelectedRangeChange: (range) =>
//                  print("Range is ${range.item1}, ${range.item2}"),
//              onDateSelected: (date) => handleNewDate(date),
//            ),
            new Divider(
              height: 50.0,
            ),
            new Text('The Expanded Calendar:'),
            new Calendar(
              onSelectedRangeChange: (range) =>
                  print("Range is ${range.item1}, ${range.item2}"),
              isExpandable: true,
            ),
            new Divider(
              height: 50.0,
            ),
            new Text('A Custom Weekly Calendar:'),
            new Calendar(
              onSelectedRangeChange: (range) =>
                  print("Range is ${range.item1}, ${range.item2}"),
              isExpandable: true,
              dayBuilder: (BuildContext context, DateTime day) {
                return new InkWell(
                  onTap: () => print("OnTap ${day}"),
                  child: new Container(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.black38)),
                    child: new Text(
                      day.day.toString(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
//    return new Container(
//      child: new Column(children: <Widget>[
//        new Container(
//          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
//          // this sets the color of the UserListItem (cards)
//          child: _buildTextComposer(),
//        ),
//        new Divider(height: 1.0), // userListItem Dividers
//        new Calendar(
//          // A builder function that renders each calendar tile how you'd like.
//            dayBuilder: new Text('!')
//        ),
////        new Flexible(
////          child: (_textController.text != "")
////              ? new ListView(
////            children: _buildFriendsList(allUserEventsDataList),
////          )
////              : new EventsList(),
//////            new ListView(children: _buildChatsList(),)
////        ),
//      ]),
//    );
  }

  // This is a text input for search textfield
  Widget _buildTextComposer() {
    return new IconTheme(
      // This could just start with the container (icon theme is not necessary)
        data: new IconThemeData(
            color:
            Theme.of(context).accentColor), // This just changes the color.
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                // Prevents using send button when there is no search text typed
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
//                  // show chats that match the search
                  _getEventsMatching(text);
                },
//                // I don't know why I dont pass in a string to "_handlesSubmitted here... but it works
//                onSubmitted: (_isComposing) ? _handleSubmitted : null,

                decoration: new InputDecoration.collapsed(
                    hintText: "Search for an Event"),
//                keyboardType: TextInputType.text,
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.clear),
                  // Prevents using send button when there is no search text typed
//                  onPressed: _isComposing
//                      ? () => _handleSubmitted(_textController.text)
//                      : null),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null),
            ),
          ]),
        ));
  }

  // This handles submitting search item
  Future<Null> _handleSubmitted(String text) async {
    // this clears edit text field
    _textController.clear();

    // Prevents using send button when there is no search text typed
    setState(() {
      _isComposing = false;
    });

    // show only events that match the search
    _getEventsMatching(_textController.text);
  }

// update results and UI to to show what the user searched for
  void _getEventsMatching(String searchInput) {

  }




  /// Create list of user friends.
  List<_EventListItem> _buildFriendsList(
      List<MyFBDocuments.EventItem> eventItemInput) {
    var items = new List<_EventListItem>();
    for (var eventData in eventItemInput) {
      items.add(new _EventListItem(eventData));
    }
    return items;
  }
}

/// List of user events
class EventsList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        // single event item
        new _EventListItem(FakeData.fakeEventData2)
      ],
    );
  }
}

/// This is one contact list item.
class _EventListItem extends StatelessWidget {
  _EventListItem(this.eventDocument);

  final MyFBDocuments.EventItem eventDocument;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
        onPressed: () {
          // todo open event TabView view

          // open another

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                EventTabView.EventTabView(OpenEventDocument: eventDocument)),
          );
          // open event detail page
          Navigator.of(context).pushNamed("/EventTabView");
        },
        child: new Container(
          // could just return container
          //modified
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(eventDocument.title),
                      // Display userListItem from Firebase Database
                      new Text(eventDocument.activity,
                          style: Theme.of(context).textTheme.subhead),
                    ],
                  ),
                ),
              ],
            )));
  }

/// Send message to designated friend.
//  _sendMessageToFriend(
//      BuildContext context, String friendUid, String friendName) {
//    // Update information to send to MessengerDetailPage.dart
//    MyVariables.chatIDForDetail = eventDocument[MyConstants.chatID2];
//    MyVariables.chatNameForDetail =
//        friendName; //.substring(0, friendName.indexOf(" "));
//
//    MyVariables.chatInfoItemForDetail = new eventDocument;
//
//    // notify MessengerDetailPage.dart that I am not opening a group chat
//    MyVariables.openingGroupMessenger = false;
//
//    // open new messenger detail page and pass chatID
//    /// Opens a detailed messenger page to the specified chat page.
//    Navigator
//        .of(context)
//        .pushNamed("/MessengerDetailPage/${MyVariables.chatIDForDetail}");
//
//    // Opens DetailedMessenger page
////    _openDetailedMessengerPage(context, MyVariables.chatID);
//  }

/// Opens a detailed messenger page to the specified chat page.
//  _openDetailedMessengerPage(BuildContext context, String chatID) {
////    new MyMessengerDetailPage.MessengerDetailPage(chatID: chatID, friendName: friendName);
//
////    final FCMNotificationsUtil.Item item = _itemForMessage(chatID);
//
////    item.route.isActive;
//
////    if (!item.route.isCurrent) {
////      Navigator.push(context, item.route);
////    }
//
////    Navigator.push(context, item.route);
//
//    // open new messenger detail page and pass chatID
////    "/MessengerDetailPage": (BuildContext context) => new MessengerDetailPage.MessengerDetailPage(),
////    Navigator.of(context).pushNamed("/MessengerDetailPage");
//
//    // information to pass to MessengerDetailPage
////    MyVariables.chatID = message['chatID'];
//    // this is the group name or the recipient name
////    MyVariables.chatNameSend = message['senderName'];
//    // notify MessengerDetailPage.dart if I am opening a group chat or a direct chat
////    if (message['openedGroupChat'] == "true") {
////      MyVariables.openingGroupMessenger = true;
////    } else {
////      MyVariables.openingGroupMessenger = false;
////    }
//    // open new messenger detail page and pass chatID
////    Navigator
////        .of(context)
////        .pushNamed("/MessengerDetailPage/${MyVariables.chatIDForDetail}");
//  }

//  FCMNotificationsUtil.Item _itemForMessage(chatID) {
////  final String itemId = message['chatID'];
//
//    final FCMNotificationsUtil.Item item = FCMNotificationsUtil.items
//        .putIfAbsent(chatID, () => new FCMNotificationsUtil.Item(itemId: chatID));
////    ..status = message['message'];
//
//    return item;
//  }
}
