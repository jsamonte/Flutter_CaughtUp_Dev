/// User Document item.
class UserPersonItem {
  // fields
  String displayName;
  String email;
  String photoUrl;
  DateTime timestampCreated;
  DateTime timestampModified;
  String uid;

  // constructor if manually adding
  UserPersonItem({
    this.displayName,
    this.email,
    this.photoUrl,
    this.timestampCreated,
    this.timestampModified,
    this.uid,
  });

//  // constructor to map new item from json
//  UserPersonItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.email = snapshot['email'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.timestampCreated = snapshot['timestampCreated'] ?? null;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//  }
//
//  // constructor to map new item from userCredential class
//  UserPersonItem.fromUserCredentials(
//      MyAuthentication.UserCredentials userCredential) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = userCredential.displayName ?? null;
//    this.email = userCredential.email ?? null;
//    this.photoUrl = userCredential.photoURL ?? null;
//    this.timestampCreated = null;
//    this.timestampModified = null;
//    this.uid = userCredential.uid ?? null;
//  }

  // constructor to map new item from friendrequest class
  UserPersonItem.fromFriendRequestItem(FriendRequestItem item) {
    // if no value or field does not exist then set field to ""
    this.displayName = item.displayName1 ?? null;
    this.email = item.email1 ?? null;
    this.photoUrl = item.photoUrl1 ?? null;
    this.timestampCreated = null;
    this.timestampModified = null;
    this.uid = item.uid1 ?? null;
  }

//  // search via name, id, school, grade, program,
//  // determines if string is a partial match to the data
//  bool partialMatch(String objString) {
//    if (this.name.contains(objString) || identical(this.name, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else if (this.details.contains(objString) ||
//        identical(this.details, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else {
//      // not a match
//      return false;
//    }
//  }

  Map<String, dynamic> toMapString() {
    return {
      'displayName': this.displayName,
      'email': this.email,
      'photoUrl': this.photoUrl,
      'timestampCreated': this.timestampCreated,
      'timestampModified': this.timestampModified,
      'uid': this.uid,
    };
  }
}

////////////////////////////////////////////////////////////////////////////////

/// User Friend Document item.
/// This document is located whithin a user's node
class UserFriendItem {
  // fields
  String displayName;
  String email;
  String photoUrl;
  DateTime timestampCreated;
  DateTime timestampModified;
  String uid;
  String chatId;

  // constructor if manually adding
  UserFriendItem(
      {this.displayName,
      this.email,
      this.photoUrl,
      this.timestampCreated,
        this.timestampModified,
      this.uid,
      this.chatId});

//  // constructor to map new item from json
//  UserFriendItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.email = snapshot['email'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.timestampCreated = snapshot['timestampCreated'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//    this.chatId = snapshot['chatId'] ?? null;
//  }

//  // constructor to map new item from userCredential class
//  UserFriendItem.fromUserCredentials(MyAuthentication.UserCredentials userPerson){
//    // if no value or field does not exist then set field to ""
//    this.displayName = userPerson.displayName ?? "";
//    this.email = userPerson.email ?? "";
//    this.photoUrl = userPerson.photoURL ?? "";
//    this.timestampCreated = null;
//    this.uid = userPerson.uid ?? "";
//  }

  // constructor to map new item from userCredential class
  UserFriendItem.fromUserPersonItem(UserPersonItem userPerson) {
    // if no value or field does not exist then set field to ""
    this.displayName = userPerson.displayName ?? null;
    this.email = userPerson.email ?? null;
    this.photoUrl = userPerson.photoUrl ?? null;
    this.timestampCreated = userPerson.timestampCreated;
    this.timestampModified = userPerson.timestampModified;
    this.uid = userPerson.uid ?? null;
  }

//  // constructor to map new item from friendrequest class
//  UserFriendItem.fromFriendRequestItem(FriendRequestItem item){
//    // if no value or field does not exist then set field to ""
//    this.displayName = item.displayName ?? "";
//    this.email = item.email ?? "";
//    this.photoUrl = item.photoUrl ?? "";
//    this.timestampCreated = null;
//    this.uid = item.uid ?? "";
//  }

//  // search via name, id, school, grade, program,
//  // determines if string is a partial match to the data
//  bool partialMatch(String objString) {
//    if (this.name.contains(objString) || identical(this.name, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else if (this.details.contains(objString) ||
//        identical(this.details, objString)) {
//      // If name contains a substring of objString or is itentical to objString
//      return true;
//    } else {
//      // not a match
//      return false;
//    }
//  }

  Map<String, dynamic> toMapString() {
    return {
      'displayName': this.displayName,
      'email': this.email,
      'photoUrl': this.photoUrl,
      'timestampCreated': this.timestampCreated,
      'timestampModified': this.timestampModified,
      'uid': this.uid,
      'chatID': this.chatId,
    };
  }
}

////////////////////////////////////////////////////////////////////////////////

/// Friend Request Document item.
class FriendRequestItem {
  // fields
  String type;

  String displayName1;
  String email1;
  String photoUrl1;
  String uid1;

  String displayName2;
  String email2;
  String photoUrl2;
  String uid2;

  DateTime timestampCreated;
  String docId;

  // constructor if manually adding
  FriendRequestItem(
      {this.type,
      this.displayName1,
      this.email1,
      this.photoUrl1,
      this.uid1,
      this.displayName2,
      this.email2,
      this.photoUrl2,
      this.uid2,
      this.timestampCreated,
      this.docId});

//  // constructor to map new item from json
//  FriendRequestItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.type = snapshot['type'] ?? null;
//
//    this.displayName1 = snapshot['displayName1'] ?? null;
//    this.email1 = snapshot['email1'] ?? null;
//    this.photoUrl1 = snapshot['photoUrl1'] ?? null;
//    this.uid1 = snapshot['uid1'] ?? null;
//
//    this.displayName2 = snapshot['displayName2'] ?? null;
//    this.email2 = snapshot['email2'] ?? null;
//    this.photoUrl2 = snapshot['photoUrl2'] ?? null;
//    this.uid2 = snapshot['uid2'] ?? null;
//
//    this.timestampCreated = snapshot['timestampCreated'] ?? null;
//    this.docId = snapshot['docId'] ?? null;
//  }

  Map<String, dynamic> toMapString() {
    return {
      'type': this.type,
      'displayName1': this.displayName1,
      'email1': this.email1,
      'photoUrl1': this.photoUrl1,
      'uid1': this.uid1,
      'displayName2': this.displayName2,
      'email2': this.email2,
      'photoUrl2': this.photoUrl2,
      'uid2': this.uid2,
      'timestampCreated': this.timestampCreated,
      'docId': this.docId
    };
  }
}

////////////////////////////////////////////////////////////////////////////////

/// User Chat Document item.
class ChatInfoItem {
  // fields
  String displayName;
  String photoUrl;
  int membersCount;
  DateTime timestampModified;
  DateTime timestampViewed;
  String chatId;
  bool isGroupChat;

  // constructor if manually adding
  ChatInfoItem(
      {this.displayName,
      this.photoUrl,
      this.membersCount,
      this.timestampModified,
      this.timestampViewed,
      this.chatId,
      this.isGroupChat});

//  // constructor to map new item from json
//  ChatInfoItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.membersCount = snapshot['membersCount'] ?? 0;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//    this.timestampViewed = snapshot['timestampViewed'] ?? null;
//    this.chatId = snapshot['chatId'] ?? null;
//    this.isGroupChat = snapshot['isGroupChat'] ?? false;
//  }

  // constructor to map new item from userCredential class
  ChatInfoItem.fromUserFriendItem(UserFriendItem personItem) {
    this.displayName = personItem.displayName ?? null;
    this.photoUrl = personItem.photoUrl ?? null;
//    this.membersCount = snapshot['membersCount'] ?? 0;
//    this.lastModified = snapshot['lastModified'] ?? null;
//    this.lastViewed = snapshot['lastViewed'] ?? null;
    this.chatId = personItem.chatId ?? null;
    this.isGroupChat = false;
  }

  // constructor to map new item from userCredential class
  ChatInfoItem.fromChatMessageItemForGroup(ChatMessageItem message) {
    this.displayName = message.actionGroupName ?? null;
    this.photoUrl = message.imageId ?? null;
//    this.membersCount = snapshot['membersCount'] ?? 0;
//    this.lastModified = snapshot['lastModified'] ?? null;
//    this.lastViewed = snapshot['lastViewed'] ?? null;
    this.chatId = message.actionGroupId ?? null;
    this.isGroupChat = true;
  }

  // constructor to map new item from userCredential class
  ChatInfoItem.fromChatMessageItem(ChatMessageItem message) {
    this.displayName = message.senderName ?? "Not available";
    this.photoUrl = message.imageId ?? null;
//    this.membersCount = snapshot['membersCount'] ?? 0;
//    this.lastModified = snapshot['lastModified'] ?? null;
//    this.lastViewed = snapshot['lastViewed'] ?? null;
    this.chatId = message.chatId ?? null;
    this.isGroupChat = message.isGroupChat ?? false;
  }

  Map<String, dynamic> toMapString() {
    return {
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'membersCount': this.membersCount,
      'timestampModified': this.timestampModified,
      'timestampViewed': this.timestampViewed,
      'chatId': this.chatId,
      'isGroupChat': this.isGroupChat,
    };
  }
}

/////////////////////////////////////////////////////////////////////////////

/// Organization Document item.
class OrganizationInfoItem {
  // fields
  String displayName;
  String photoUrl;
  int membersCount;
  DateTime lastModified;
  DateTime lastViewed;
  String orgID;
  String uid;

  // constructor if manually adding
  OrganizationInfoItem(
      {this.displayName,
      this.photoUrl,
      this.membersCount,
      this.lastModified,
      this.lastViewed,
      this.orgID,
      this.uid});

//  // constructor to map new item from json
//  OrganizationInfoItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.membersCount = snapshot['membersCount'] ?? 0;
//    this.lastModified = snapshot['lastModified'] ?? null;
//    this.lastViewed = snapshot['lastViewed'] ?? null;
//    this.orgID = snapshot['orgID'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//  }

  Map<String, dynamic> toMapString() {
    return {
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'membersCount': this.membersCount,
      'lastModified': this.lastModified,
      'lastViewed': this.lastViewed,
      'chatID': this.orgID,
      'uid': this.uid
    };
  }
}

//////////////////////////////////////////////////////////////////////////////

/// Chat Message Document item.
class ChatMessageItem {
  // fields
  String type;
  String actionGroupId;
  String actionGroupName;
  String actionTitle;
  String chatId;
  String docId;
  String messageId;
  String senderName;
  String senderPhotoUrl;
  String text;
  String imageId;
  String imageUrl;
  DateTime timestampModified;
  String senderId;
  bool isGroupChat;

  // constructor if manually adding
  ChatMessageItem(
      {this.type,
      this.actionGroupId,
      this.actionGroupName,
      this.actionTitle,
      this.chatId,
      this.docId,
      this.messageId,
      this.senderName,
      this.senderPhotoUrl,
      this.text,
      this.imageId,
      this.imageUrl,
      this.timestampModified,
      this.senderId,
      this.isGroupChat});

//  // constructor to map new item from json
//  ChatMessageItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.type = snapshot['type'] ?? null;
//    this.actionGroupId = snapshot['actionGroupId'] ?? null;
//    this.actionGroupName = snapshot['actionGroupName'] ?? null;
//    this.actionTitle = snapshot['actionTitle'] ?? null;
//    this.chatId = snapshot['chatId'] ?? null;
//    this.docId = snapshot['docId'] ?? null;
//    this.messageId = snapshot['messageId'] ?? null;
//    this.senderName = snapshot['senderName'] ?? null;
//    this.senderPhotoUrl = snapshot['senderPhotoUrl'] ?? null;
//    this.text = snapshot['text'] ?? null;
//    this.imageId = snapshot['imageId'] ?? null;
//    this.imageUrl = snapshot['imageUrl'] ?? null;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//    this.senderId = snapshot['senderId'] ?? null;
//    this.isGroupChat = snapshot['isGroupChat'] ?? null;
//  }

  // constructor to map new item from a map
  ChatMessageItem.fromMap(Map<dynamic, dynamic> map) {
    // if no value or field does not exist then set field to ""
    this.type = map['type'] ?? null;
    this.actionGroupId = map['actionGroupId'] ?? null;
    this.actionGroupName = map['actionGroupName'] ?? null;
    this.actionTitle = map['actionTitle'] ?? null;
    this.chatId = map['chatId'] ?? null;
    this.docId = map['docId'] ?? null;
    this.messageId = map['messageId'] ?? null;
    this.senderName = map['senderName'] ?? null;
    this.senderPhotoUrl = map['senderPhotoUrl'] ?? null;
    this.text = map['text'] ?? null;
    this.imageId = map['imageId'] ?? null;
    this.imageUrl = map['imageUrl'] ?? null;
    this.timestampModified = map['timestampModified'] ?? null;
    this.senderId = map['senderId'] ?? null;
    this.isGroupChat = map['isGroupChat'] == 'true';
  }

  // Convert Map<String, String>
  Map<String, dynamic> toMapString() {
    return {
      'type': this.type,
      'actionGroupId': this.actionGroupId,
      'actionGroupName': actionGroupName,
      'actionTitle': actionTitle,
      'chatId': this.chatId,
      'docId': this.docId,
      'messageId': this.messageId,
      'senderName': this.senderName,
      'senderPhotoUrl': this.senderPhotoUrl,
      'text': this.text,
      'imageId': this.imageId,
      'imageUrl': this.imageUrl,
      'timestampModified': this.timestampModified.toString(),
      'senderId': this.senderId,
      'isGroupChat': this.isGroupChat
    };
  }
}

//////////////////////////////////////////////////////////////////////////////

/// User Chat Document item.
class ChatMemberItem {
  // fields
  String displayName;
  String photoUrl;
  DateTime timestampCreated;
  String uid;
  String chatId;

  // constructor if manually adding
  ChatMemberItem(
      {this.displayName,
      this.photoUrl,
      this.timestampCreated,
      this.uid,
      this.chatId});

//  // constructor to map new item from json
//  ChatMemberItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.displayName = snapshot['displayName'] ?? null;
//    this.photoUrl = snapshot['photoUrl'] ?? null;
//    this.timestampCreated = snapshot['timestampCreated'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//    this.chatId = snapshot['chatId'] ?? null;
//  }

  Map<String, dynamic> toMapString() {
    return {
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'timestampCreated': this.timestampCreated,
      'uid': this.uid,
      'chatId': this.chatId
    };
  }
}

/////////////////////////////////////////////////////////////////////////////////

/// calendar Document item.
class EventItem {
  // fields
  String title;
  DateTime endTime;
  String activity;
  String calendar;
  String groupID;
  String note;
  DateTime timecreated;
  DateTime lastModified;
  String owner;
  DateTime startTime;
  String documentID;

  // constructor if manually adding
  EventItem(
      {this.title,
      this.endTime,
      this.activity,
      this.calendar,
      this.groupID,
      this.note,
      this.timecreated,
      this.lastModified,
      this.owner,
      this.startTime,
      this.documentID});

  // constructor to map new item from json
//  EventItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.title = snapshot['title'] ?? null;
//    this.endTime = snapshot['endTime'] ?? null;
//    this.activity = snapshot['activity'] ?? null;
//    this.calendar = snapshot['calendar'] ?? null;
//    this.groupID = snapshot['groupID'] ?? null;
//    this.note = snapshot['note'] ?? null;
//    this.timecreated = snapshot['timecreated'] ?? null;
//    this.lastModified = snapshot['lastModified'] ?? null;
//    this.owner = snapshot['owner'] ?? null;
//    this.startTime = snapshot['startTime'] ?? null;
//    this.documentID = snapshot['documentID'] ?? null;
//  }

  Map<String, dynamic> toMapString() {
    return {
      'title': this.title,
      'endTime': this.endTime,
      'activity': this.activity,
      'calendar': this.calendar,
      'groupID': this.groupID,
      'note': this.note,
      'timecreated': this.timecreated,
      'lastModified': this.lastModified,
      'owner': this.owner,
      'startTime': this.startTime,
      'documentID': this.documentID
    };
  }
}

///////////////////////////////////////////////////////////////////////////////

/// User Device Document item.
class UserDeviceItem {
  // fields
  String FCMToken;
  String uid;

  // app information
  String appName;
  String packageName;
  String version;
  String buildNumber;
  DateTime timestampModified;

  // constructor if manually adding
  UserDeviceItem({this.FCMToken, this.uid, this.appName, this.packageName, this.version, this.buildNumber, this.timestampModified});

//  // constructor to map new item from json
//  UserDeviceItem.fromDocumentSnapshot(DocumentSnapshot snapshot) {
//    // if no value or field does not exist then set field to ""
//    this.FCMToken = snapshot['FCMToken'] ?? null;
//    this.uid = snapshot['uid'] ?? null;
//    this.appName = snapshot['appName'] ?? null;
//    this.packageName = snapshot['packageName'] ?? null;
//    this.version = snapshot['version'] ?? null;
//    this.buildNumber = snapshot['buildNumber'] ?? null;
//    this.timestampModified = snapshot['timestampModified'] ?? null;
//  }

  Map<String, dynamic> toMapString() {
    return {
      'FCMToken': this.FCMToken,
      'uid': this.uid,
      'appName': this.appName,
      'packageName': this.packageName,
      'version': this.version,
      'buildNumber': this.buildNumber,
      'timestampModified': this.timestampModified,
    };
  }
}

////////////////////////////////////////////////////////////////////////////////
