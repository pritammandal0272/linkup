import 'dart:developer';

class DummyData {
  // ============== All Users Data ====================
  static final List<Map<String, dynamic>> users = [
    {
      "email": "pritam@gmail.com",
      "name": "Pritam Mandal",
      "profilePic": "assets/appicon.png",
      "isOnline": true,
    },
    {
      "email": "amit@gmail.com",
      "name": "Amit Sharma",
      "profilePic": "",
      "isOnline": true,
    },
    {
      "email": "riya@gmail.com",
      "name": "Riya Das",
      "profilePic": "",
      "isOnline": false,
    },
    {
      "email": "rahul@gmail.com",
      "name": "Rahul Verma",
      "profilePic": "",
      "isOnline": true,
    },
    {
      "email": "sneha@gmail.com",
      "name": "Sneha Roy",
      "profilePic": "",
      "isOnline": false,
    },
    {
      "email": "pooja@gmail.com",
      "name": "Puja Roy",
      "profilePic": "assets/appicon.png",
      "isOnline": false,
    },
  ];
  //================= Chat Room Data (Like conversition Pritam to Madhab) ==================
  static final List<Map<String, dynamic>> rooms = [
    {
      "roomId": "amit@gmail.com_pritam@gmail.com",
      "users": ["amit@gmail.com", "pritam@gmail.com"], 
      "unreadCount": 1,
    },
    {
      "roomId": "pritam@gmail.com_riya@gmail.com",
      "users": ["pritam@gmail.com", "riya@gmail.com"],
      "unreadCount": 0,
    },
    {
      "roomId": "pritam@gmail.com_rahul@gmail.com",
      "users": ["pritam@gmail.com", "rahul@gmail.com"],
      "unreadCount": 1,
    },
    {
      "roomId": "pritam@gmail.com_sneha@gmail.com",
      "users": ["pritam@gmail.com", "sneha@gmail.com"],
      "unreadCount": 0,
    },
    {
      "roomId": "pritam@gmail.com_pooja@gmail.com",
      "users": ["pritam@gmail.com", "pooja@gmail.com"],
      "unreadCount": 1,
    },
  ];

  // ================== Message Per Room ======================
  static final Map<String, List<Map<String, dynamic>>> messages = {
    "amit@gmail.com_pritam@gmail.com": [
      {
        "id": "m1",
        "senderEmail": "pritam@gmail.com",
        "receiverEmail": "amit@gmail.com",
        "text": "Hey Amit! Kemon acho?",
        "time": "2026-01-26 10:30:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
      {
        "id": "m2",
        "senderEmail": "amit@gmail.com",
        "receiverEmail": "pritam@gmail.com",
        "text": "Hi Pritam! Bhalo achi 🙂",
        "time": "2026-01-26 10:32:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
    ],
    "pritam@gmail.com_riya@gmail.com": [
      {
        "id": "m3",
        "senderEmail": "riya@gmail.com",
        "receiverEmail": "pritam@gmail.com",
        "text": "Kal milte hain 🙂",
        "time": "2026-01-25 09:15:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
      {
        "id": "m4",
        "senderEmail": "pritam@gmail.com",
        "receiverEmail": "riya@gmail.com",
        "text": "Sure Riya!",
        "time": "2026-01-25 09:17:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
    ],
    "pritam@gmail.com_rahul@gmail.com": [
      {
        "id": "m5",
        "senderEmail": "rahul@gmail.com",
        "receiverEmail": "pritam@gmail.com",
        "text": "Typing...",
        "time": "2026-01-25 11:00:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
    ],
    "pritam@gmail.com_sneha@gmail.com": [
      {
        "id": "m6",
        "senderEmail": "pritam@gmail.com",
        "receiverEmail": "sneha@gmail.com",
        "text": "Thanks ❤️",
        "time": "2026-01-24 18:30:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
    ],
    "pritam@gmail.com_pooja@gmail.com": [
      {
        "id": "m7",
        "senderEmail": "pooja@gmail.com",
        "receiverEmail": "pritam@gmail.com",
        "text": "Call me when free",
        "time": "2026-01-26 08:40:00",
        "isSent": true,
        "isDelivered": true,
        "isSeen": false,
      },
    ],
  };
  static List userContectdataList = [];
  static final myUserId = "pritam@gmail.com";

  static Future userContectdata() async {
    for (var roomElement in rooms) {
      // ======= Using my email another room users email find Start==========
      var myEmailIndex = roomElement["users"].indexWhere((i) => i == myUserId);
      int otherEmailIndex;
      if (myEmailIndex == 0) {
        otherEmailIndex = 1;
      } else {
        otherEmailIndex = 0;
      }
      // ======= Using my email another room users email find End==========

      var index = users.indexWhere(
        (userElement) =>
            userElement["email"] == roomElement["users"][otherEmailIndex],
      );
      // Last Chat Data Find
      var roomKey = getRoomKey(roomElement["roomId"]);
      final lastChat =
    messages[roomKey] != null && messages[roomKey]!.isNotEmpty
        ? messages[roomKey]!.last
        : null;
      if (index != -1) {
        var data = {
          ...roomElement,
          ...users[index],
          "lastchat": lastChat,
        };

        userContectdataList.add(data);
      }
    }
    log(userContectdataList.toString());
    return userContectdataList;
  }

  static String? getRoomKey(String roomId) {
    if (messages.containsKey(roomId)) return roomId;

    final parts = roomId.split("_");
    final reverseKey = "${parts[1]}_${parts[0]}";

    if (messages.containsKey(reverseKey)) return reverseKey;

    return null;
  }
}
