import './MyFBDocuments.dart' as MyFBDocuments;

import './MyFBConstants.dart' as MyFBConstants;

MyFBDocuments.UserPersonItem friendWithConflict = new MyFBDocuments.UserPersonItem(

    displayName: "James Bond",
    email: "bond@james.com",
    photoUrl: "https://i2.wp.com/beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg?w=640&ssl=1",
    timestampCreated: new DateTime.now(),
    timestampModified: new DateTime.now(),
    uid: "unique id",

);
MyFBDocuments.EventItem fakeEventData1 = new MyFBDocuments.EventItem(
title: "D2 Dinner",
endTime: new DateTime.now(),
activity: "Activity ",
calendar: MyFBConstants.FreeTimeCalendar3,
groupID: "unique group ID",
note: "I feel like eating at D2.",
timecreated: new DateTime.now(),
lastModified: new DateTime.now(),
owner: "owner uid",
startTime: new DateTime.now(),
documentID: "Unique Document ID"
);

MyFBDocuments.EventItem fakeEventData2 = new MyFBDocuments.EventItem(
    title: "D2 Dinner",
    endTime: new DateTime.now(),
    activity: "Activity ",
    calendar: MyFBConstants.FreeTimeCalendar3,
    groupID: "unique group ID",
    note: "I feel like eating at D2.",
    timecreated: new DateTime.now(),
    lastModified: new DateTime.now(),
    owner: "owner uid",
    startTime: new DateTime.now(),
    documentID: "Unique Document ID"
);