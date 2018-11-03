import 'package:flutter/material.dart';

import 'package:flutter_caughtup_dev/Utility/FakeData.dart' as FakeData;
import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart'
    as MyFBDocuments;

import 'package:flutter_calendar/flutter_calendar.dart';

/// Contact Detail Page which displays information on a person.
class CalSubWeekView extends StatefulWidget {
//  static const String routeName = '/contacts';
// here is a state object now defined in MessengerDetailPage
  CalSubWeekView({Key key}) : super(key: key);

//  final DocumentSnapshot personInformationDocument;

  @override
  CalSubScheduleViewPageState createState() =>
      new CalSubScheduleViewPageState();
}

/// Contact Detail page state.
class CalSubScheduleViewPageState extends State<CalSubWeekView> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: new EventsGrid(
            allEvents: FakeData.allUserEvents,
          ),
        )
      ],
    );
  }
}

final hourHeight = 100.0;

// this is the grid that will be an
class EventsGrid extends StatelessWidget {
  EventsGrid({Key key, this.allEvents}) : super(key: key);

  final List<MyFBDocuments.EventItem> allEvents;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[

        new Container(
            child: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Calendar(
                onSelectedRangeChange: (range) =>
                    print("Range is ${range.item1}, ${range.item2}"),
                isExpandable: true,
              ),
//              new Divider(
//                height: 4.0,
//              ),
            ],
          ),
        )),

        new SizedBox(
          height: hourHeight * 24,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TimeColumn(),
              new DayEventsColumn(
                dayEvents: allEvents,
              ),
//          new DayColumn(
//            dayEvents: allEvents,
//          )
            ],
          ),
        )
      ],
    );
  }
}

class DayEventsColumn extends StatelessWidget {
  DayEventsColumn({Key key, this.dayEvents}) : super(key: key);

  final List<MyFBDocuments.EventItem> dayEvents;

  List<EventItem> eventItems = new List<EventItem>();

  // todo get a list of events

  @override
  Widget build(BuildContext context) {
    for (MyFBDocuments.EventItem x in dayEvents) {
      print(x.startTime.hour);
      eventItems.add(new EventItem(
        eventDoc: x,
      ));
      print(eventItems.toString());
    }

    return new Expanded(
        flex: 3,
        child: new Stack(
//          children: dayEvents.map((item) => new EventItem(eventDoc: item)).toList(),
//          children: getTextWidgets(eventItems),
          children: eventItems,
//          children: <Widget>[
//            new EventItem(
//              eventDoc: dayEvents[0],
//            ),
//            new EventItem(
//              eventDoc: dayEvents[1],
//              color: Colors.red,
//            )
//          ],
        ));
  }
}

class TimeColumn extends StatelessWidget {
  TimeColumn({Key key}) : super(key: key);

  List<TimeItem> timeItems = new List<TimeItem>();

  // todo get a list of events

  @override
  Widget build(BuildContext context) {
    for (int x = 0; x < 24; x++) {
      print(x);
      timeItems.add(new TimeItem(hour: x));
      print(timeItems.toString());
    }

    return new Expanded(
        flex: 1,
        child: new Stack(
//          children: dayEvents.map((item) => new EventItem(eventDoc: item)).toList(),
//          children: getTextWidgets(eventItems),
          children: timeItems,
//          children: <Widget>[
//            new EventItem(
//              eventDoc: dayEvents[0],
//            ),
//            new EventItem(
//              eventDoc: dayEvents[1],
//              color: Colors.red,
//            )
//          ],
        ));
  }
}

class TimeItem extends StatelessWidget {
  TimeItem({Key key, this.hour, this.color}) : super(key: key);

  final int hour;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      left: 0.0,
      top: hourHeight * hour,
//      width: 200.0,
      right: 0.0,
      height: hourHeight,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
//        color: (color != null) ? color : Colors.orange,
//        margin: const EdgeInsets.all(15.0),
//        padding: const EdgeInsets.all(3.0),
          decoration:
              new BoxDecoration(border: new Border.all(color: Colors.orange)),
          child: new Column(
            children: <Widget>[
              new Text(hour.toString()),
//              new Text(eventDoc.startTime.toString()),
//              new Text(eventDoc.endTime.toString())
            ],
          )),
    );
  }
}

class EventItem extends StatelessWidget {
  EventItem({Key key, this.eventDoc, this.color}) : super(key: key);

  final MyFBDocuments.EventItem eventDoc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    int hourDuration = eventDoc.endTime.hour - eventDoc.startTime.hour;

    print(eventDoc.endTime.hour.toString() +
        " /// " +
        eventDoc.startTime.hour.toString());
    print("asdf" + hourDuration.toString());

    return new Positioned(
      left: 0.0,
      top: hourHeight * eventDoc.startTime.hour,
//      width: 200.0,
      right: 0.0,
      height: hourHeight * hourDuration,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
//        color: (color != null) ? color : Colors.orange,
//        margin: const EdgeInsets.all(15.0),
//        padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.blueAccent)),
          child: new Column(
            children: <Widget>[
              new Text(eventDoc.title),
              new Text(eventDoc.startTime.toString()),
              new Text(eventDoc.endTime.toString())
            ],
          )),
    );
  }
}

//class EventItem extends StatelessWidget {
//  EventItem({Key key, this.eventDoc, this.color})
//      : super(key: key);
//
//  final MyFBDocuments.EventItem eventDoc;
//  final Color color;
//
//  @override
//  Widget build(BuildContext context) {
//    int hourDuration = eventDoc.endTime.hour - eventDoc.startTime.hour;
//
//    print(eventDoc.endTime.hour.toString()+ " /// " + eventDoc.startTime.hour.toString());
//    print("asdf" + hourDuration.toString());
//    return new Positioned(
//      left: 0.0,
//      top: hourHeight * eventDoc.startTime.hour,
//      right: 0.0,
//      height: hourHeight * hourDuration,
//      child: Container(
//        margin: EdgeInsets.symmetric(horizontal: 2.0),
////        color: (color != null) ? color : Colors.orange,
////        margin: const EdgeInsets.all(15.0),
////        padding: const EdgeInsets.all(3.0),
//        decoration: new BoxDecoration(
//            border: new Border.all(color: Colors.blueAccent)
//        ),
//        child:
//        new Column(
//          children: <Widget>[
//            new Text(eventDoc.title),
//            new Text(eventDoc.startTime.toString()),
//            new Text(eventDoc.endTime.toString())
//          ],
//        )
//
//      ),
//    );
//  }
//}
