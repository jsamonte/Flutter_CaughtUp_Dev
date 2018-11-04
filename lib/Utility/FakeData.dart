import 'package:flutter_caughtup_dev/Utility/MyFBDocuments.dart'
    as MyFBDocuments;

import 'package:flutter_caughtup_dev/Utility/MyFBConstants.dart'
    as MyFBConstants;

MyFBDocuments.UserPersonItem friendWithConflict =
    new MyFBDocuments.UserPersonItem(
  displayName: "James Bond",
  email: "bond@james.com",
  photoUrl:
      "https://i2.wp.com/beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg?w=640&ssl=1",
  timestampCreated:  new DateTime.utc(2018, DateTime.november, 9),
  timestampModified:  new DateTime.utc(2018, DateTime.november, 9),
  uid: "unique id",
);

MyFBDocuments.EventItem fakeEventData1 = new MyFBDocuments.EventItem(
    title: "D2 Dinner",
    endTime: new DateTime.utc(2018, DateTime.november, 9, 2),
    activity: "Hangout",
    calendar: MyFBConstants.FreeTimeCalendar3,
    groupID: "unique group ID",
    note: "I feel like eating at D2.",
    timecreated:  new DateTime.utc(2018, DateTime.november, 9),
    lastModified: new DateTime.utc(2018, DateTime.november, 9),
    owner: "owner uid",
    startTime: new DateTime.utc(2018, DateTime.november, 9, 1),
    documentID: "Unique Document ID");

MyFBDocuments.EventItem fakeEventData2 = new MyFBDocuments.EventItem(
    title: "D2 Dinner",
    endTime: new DateTime.utc(2018, DateTime.november, 9, 5),
    activity: "Hangout",
    calendar: MyFBConstants.FreeTimeCalendar3,
    groupID: "unique group ID",
    note: "I feel like eating at D2.",
    timecreated: new DateTime.utc(2018, DateTime.november, 9, 1),
    lastModified: new DateTime.utc(2018, DateTime.november, 9, 2),
    owner: "owner uid",
    startTime: new DateTime.utc(2018, DateTime.november, 9, 3),
    documentID: "Unique Document ID");

MyFBDocuments.EventItem fakeEventData3 = new MyFBDocuments.EventItem(
    title: "D2 Dinner",
    endTime: new DateTime.utc(2018, DateTime.november, 9, 7),
    activity: "Hangout",
    calendar: MyFBConstants.FreeTimeCalendar3,
    groupID: "unique group ID",
    note: "I feel like eating at D2.",
    timecreated: new DateTime.utc(2018, DateTime.november, 9, 2),
    lastModified: new DateTime.utc(2018, DateTime.november, 9, 5),
    owner: "owner uid",
    startTime: new DateTime.utc(2018, DateTime.november, 9, 4),
    documentID: "Unique Document ID");

MyFBDocuments.EventItem fakeEventData4 = new MyFBDocuments.EventItem(
    title: "D2 Dinner",
    endTime: new DateTime.utc(2018, DateTime.november, 9, 15),
    activity: "Hangout",
    calendar: MyFBConstants.FreeTimeCalendar3,
    groupID: "unique group ID",
    note: "I feel like eating at D2.",
    timecreated: new DateTime.utc(2018, DateTime.november, 9, 3),
    lastModified: new DateTime.utc(2018, DateTime.november, 6),
    owner: "owner uid",
    startTime: new DateTime.utc(2018, DateTime.november, 9, 10),
    documentID: "Unique Document ID");


List<MyFBDocuments.EventItem> allUserEvents = [fakeEventData1, fakeEventData2, fakeEventData3, fakeEventData4];