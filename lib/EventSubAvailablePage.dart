
import 'package:flutter/material.dart';

import './MyFBDocuments.dart' as MyFBDocuments;
import './MyUtility.dart' as MyUtility;
import './MyScheduleFirebaseUtility.dart' as MyScheduleFirebaseUtility;
import './fakedata.dart' as fakedata;

/// A list of the users friends.
List<MyFBDocuments.UserFriendItem> userFriendsDocList = new List();

/// A list of friend events that conflict with the event on display
List<MyFBDocuments.EventItem> _friendEventsWithConflict;

/// The current string inpt in the search box.
String searchInput = "";

/// SubEventAvailable page which displays friends that are available to hangout
/// at the specified time of the event that is opened in the view.
class EventSubAvailablePage extends StatefulWidget {
//  // Optional Argument passed to "here" final and pass key to the super class
//  // here is a state object now defined in MessengerDetailPage
//  SubEventAvailablePage(
//      {Key key,
//        this.OriginalLocalDateTimeInView,
//        this.fromTime,
//      })
//      : super(key: key);
//
//  String fromTime;

  // chat screen
  @override
  State createState() => new EventSubAvailablePageState();
}

/// SubEventAvailable sub page state.
class EventSubAvailablePageState extends State<EventSubAvailablePage> {
  // 0 - show loading
  // 1 - show list with friends
  // 2 - show no friends available
  // 3 - show error has occurred
  int _showProgressIndicator;

  @override
  void initState() {
    super.initState();

    setState(() {
      _showProgressIndicator = 0;

      _friendEventsWithConflict = new List();
    });

    // Get current friends and check availability at the event time
    _getUsersFriendsWithConflict();
  }

  @override
  Widget build(BuildContext context) {
    // THis is for debug
//    print("SUBCONTACT HERE: " + MyAuthentication.emailAuthenticatedEncoded);

    return new Container(
//      padding: const EdgeInsets.all(12.0),
      child: new Column(children: <Widget>[
//        new Container(
//          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
//          // this sets the color of the UserListItem (cards)
//          child: _buildTextComposer(),
//        ),
//        new Divider(height: 1.0), // userListItem Dividers
        new Flexible(
            // List to update UI when Users are searched
//                    child: (_showProgressIndicator) ?
//
//                        new BlankAvailableFriendsContentArea()
//
////                    new CircularProgressIndicator()
//
//
//                        : new ListView(
////                          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
//                      children: _buildAvailableFriendsList(_friendEventsWithConflict),
//                    )
            child: new BlankAvailableFriendsContentArea(
                friendEventsWithConflict: _friendEventsWithConflict,
                displaySelection: _showProgressIndicator)),
      ]),
    );

//      // userListItem Dividers
//      new Expanded(
//        child: new Flex(
//          direction: Axis.vertical,
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            new Flexible(
//              // List to update UI when Users are searched
////                    child: (_showProgressIndicator) ?
////
////                        new BlankAvailableFriendsContentArea()
////
//////                    new CircularProgressIndicator()
////
////
////                        : new ListView(
//////                          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
////                      children: _buildAvailableFriendsList(_friendEventsWithConflict),
////                    )
//                child: new BlankAvailableFriendsContentArea(
//                    friendEventsWithConflict: _friendEventsWithConflict,
//                    displaySelection: _showProgressIndicator)),
//          ],
//        ),
//      );
  }

  /// Gets the user's current friends.
  void _getUsersFriendsWithConflict() {
    setState(() {
      // todo get user friends from another portion of the app rather than online
      _friendEventsWithConflict.add(fakedata.fakeEventData2);
      _showProgressIndicator = 1;
    });
  }
}

/// Empty available friends content area.
class BlankAvailableFriendsContentArea extends StatefulWidget {
  BlankAvailableFriendsContentArea({
    Key key,
    this.friendEventsWithConflict,
    this.displaySelection,
  }) : super(key: key);

  final List<MyFBDocuments.EventItem> friendEventsWithConflict;
  final int displaySelection;

  @override
  State createState() => new BlankAvailableFriendsContentAreaState();
}

/// Empty available content area state.
class BlankAvailableFriendsContentAreaState
    extends State<BlankAvailableFriendsContentArea> {
  @override
  Widget build(BuildContext context) {
    // displaySelection
    // 0 - show loading
    // 1 - show list with friends
    // 2 - show no friends view
    // 3 - show error
    switch (widget.displaySelection) {
      case 0:
        return new CircularProgressIndicator();
        break;
      case 1:
        return new ListView(
//                          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            children:
                _buildAvailableFriendsList(widget.friendEventsWithConflict));
        break;
      case 2:
        return new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.group,
                size: 100.0,
                color: Colors.orange,
              ),
              new Text("No friends available.")
            ],
          ),
        );
        break;
      default:
        return new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.error,
                size: 100.0,
                color: Colors.orange,
              ),
              new Text("An Error has occured.")
            ],
          ),
        );
    }
  }
}

/// Creates the list of available friends.
List<_AvailableFriendsListItem> _buildAvailableFriendsList(
    _friendEventsWithConflict) {
  var items = new List<_AvailableFriendsListItem>();
  for (var friendEvent in _friendEventsWithConflict) {
    items.add(new _AvailableFriendsListItem(availableFriendEvent: friendEvent));
  }
  return items;
}

/// Available friend list item which displays information on who is available and when.
class _AvailableFriendsListItem extends StatefulWidget {
  // Optional Argument passed to "here" final and pass key to the super class
  // here is a state object now defined in MessengerDetailPage
  _AvailableFriendsListItem({
    Key key,
    this.availableFriendEvent,
  }) : super(key: key);

  final MyFBDocuments.EventItem availableFriendEvent;

  // detail screen
  @override
  State createState() => new _AvailableFriendsListItemState();
}

/// Available friend list item state.
class _AvailableFriendsListItemState extends State<_AvailableFriendsListItem> {
  // This is the location of the owner of the event in UserFriendsDataList
  int ownerPositionInFriendsList = 0;

  // determine state of sendInvite button
  var _inviteSent = false;

  @override
  void initState() {
    super.initState();

    // Get position of the owner of the event in data
    for (int x = 0; x < userFriendsDocList.length; x++) {
      if (userFriendsDocList[x].uid == widget.availableFriendEvent.owner) {
        ownerPositionInFriendsList = x;
        break; // exit loop
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(2.0),
        child: new ExpansionTile(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
            leading: new Container(
//                margin: const EdgeInsets.only(right: 16.0),
              child: (fakedata.friendWithConflict.photoUrl !=
                      null)
                  ? new CircleAvatar(
                      backgroundImage: new NetworkImage(fakedata.friendWithConflict
                          .photoUrl) // display userphoto from Firebase Database
//                    new NetworkImage(googleSignIn.currentUser.photoUrl) // get google profile photo
                      )
                  : new CircleAvatar(
                      child: new Text(
                          userFriendsDocList[ownerPositionInFriendsList]
                              .displayName[0])), // old avatar
            ),
            title: new Container(
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                        onTap: () {
                          // Open MessengerDetailPage

                          // Setup information to pass to MessengerDetailPage
                          // this is the chat id of the specific friend
//                          MyVariables.chatInfoItemForDetail = new MyFBDocuments
//                                  .ChatInfoItem.fromUserFriendItem(
//                              UserFriendsDocList[ownerPositionInFriendsList]);
//                          // this is the group name or the recipient name
//                          MyVariables.chatNameForDetail =
//                              UserFriendsDocList[ownerPositionInFriendsList]
//                                  .displayName;
                          // notify MessengerDetailPage.dart if I am opening a group chat or a direct chat
//                          MyVariables.openingGroupMessenger = false;

                          // Navigate to MessengerDetailPage
//                          Navigator.of(context)
//                              .pushNamed("/MessengerDetailPage");
                        },
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                                fakedata.friendWithConflict
                                    .displayName),
                            new Text(widget.availableFriendEvent.activity),
                          ],
                        )),
                  ),
                  new Container(
                      child: new IconButton(
                          icon: (_inviteSent)
                              ? new Icon(Icons.done)
                              : new Icon(Icons.send),
                          onPressed: () {

                            setState(() {
                              _inviteSent = true;
                            });

                            // Send invite message to friend
                            _sendFriendInvite(
                                context,
                                ownerPositionInFriendsList,
                                widget.availableFriendEvent);
                          })),
                ],
              ),
            ),
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      "Times: " +
                          MyUtility.convertDateTimeToHourMinsDisplay(
                              MyScheduleFirebaseUtility
                                  .convertDateTimeUtcToDateTimeHourMinLocal(
                                      widget.availableFriendEvent.startTime)) +
                          " - " +
                          MyUtility.convertDateTimeToHourMinsDisplay(
                              MyScheduleFirebaseUtility
                                  .convertDateTimeUtcToDateTimeHourMinLocal(
                                      widget.availableFriendEvent.endTime)),
                    ),
                  ),
                  new Container(
                    // show event note only if there is a note
                    child: (widget.availableFriendEvent.note != "")
                        ? new Container(
//                    padding: const EdgeInsets.fromLTRB(0.0, ),
                            child: new Column(
                            children: <Widget>[
//                              new Text("Note:"),
                              new Text(widget.availableFriendEvent.note),
                            ],
                          ))
                        : null,
                  )
                ],
              ),
            ]));
  }

  /// Onclick sending an invite to an available friend. This will send a
  /// message regarding hanging out at during the given time.
  void _sendFriendInvite(BuildContext context, int ownerPositionInFriendsList,
      var _availableFriendEventWithOverlap) {

    // UNCOMMENT THIS
//    // if chat id does not exist yet then make one
//    // check if chat id node exist if not then create it
//    if (userDirectChatKey == null) {
//      userDirectChatKey = MyMessengerFirebaseUtility.createChatIDNode(
//          UserFriendsDataList[ownerPositionInFriendsList][MyConstants.uid2],
//          UserFriendsDataList[ownerPositionInFriendsList][MyConstants.name2],
//          UserFriendsDataList[ownerPositionInFriendsList]
//              [MyConstants.timestampJoined2],
//          UserFriendsDataList[ownerPositionInFriendsList]
//              [MyConstants.chatPhotoUrl2]);
//    }

    /// Create message to send to a friend
    /// Setup details for invite message
//    String eventTextMessage = SubEventDetailPage.SendUserEventEventMessage +
//        "\n\n" +
//        fakedata.friendWithConflict.displayName +
//        ": " +
//        _availableFriendEventWithOverlap[MyFBConstants.eventActivity2] +
//        "\n" +
//        "Time: " +
//        MyUtility.convertDateTimeToHourMinsDisplay(
//            MyScheduleFirebaseUtility.convertDateTimeUtcToDateTimeHourMinLocal(
//                _availableFriendEventWithOverlap[MyFBConstants.startTime2])) +
//        " - " +
//        MyUtility.convertDateTimeToHourMinsDisplay(
//            MyScheduleFirebaseUtility.convertDateTimeUtcToDateTimeHourMinLocal(
//                _availableFriendEventWithOverlap['endTime'])) +
//        "\n" +
//        _availableFriendEventWithOverlap[MyFBConstants.eventNote2];

//    // SendChatMessage with action (group invite) to friend with chat ID
//    MyMessengerFirebaseUtility.sendMessage(userDirectChatKey, true,
//        text: eventTextMessage,
//        actionGroupName: SubEventDetailPage.SendActivityName,
//        type: "eventInvite",
//        actionGroupId: SubEventDetailPage.SendUserEventGroupID,
//        GroupChatName: SubEventDetailPage.SendGroupName,
//        // This is the owner of the event action
//        senderId: MyAuthentication.authenticatedUser.uid);

    // notify user that an invite was sent or updated
    // Remove current snackbars on display
    Scaffold.of(context).removeCurrentSnackBar();

    // display snackbar with message
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Invite Sent to: " +
          fakedata.friendWithConflict.displayName),
      action: new SnackBarAction(
          label: 'HELP',
          onPressed: () {
            // Opens CaughtUp's Frequently Asked Questions Webpage
            MyUtility.launchURL("https://www.caughtup-app.com");
          }),
    ));
  }
}
