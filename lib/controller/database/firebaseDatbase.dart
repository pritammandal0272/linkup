import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/properties/email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDatabase {
  static final fbInstance = FirebaseFirestore.instance.collection('users');
  static final fbInstanceMessage = FirebaseFirestore.instance.collection(
    'messages',
  );
  static Future signUpInsertData(data) async {
    log(data.toString());
    try {
      fbInstance.doc("${data["email"]}").set(data);
      return true;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  static Future signInData(data) async {
    try {
      final userData = await fbInstance.doc("${data["email"]}").get();
      if (!userData.exists) {
        return false;
      }
      final user = userData.data()!;
      return user["password"] == data["password"];
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  // static Future allUsersData() async {
  //   try {
  //     final userData = fbInstance.get();
  //     return userData;
  //   } catch (err) {
  //     log(err.toString());
  //   }
  // }
  static Stream<QuerySnapshot<Map<String, dynamic>>> allUsersData() {
    try {
      return fbInstance.snapshots();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  static Future checkUserExists(email) async {
    try {
      final user = fbInstance.doc(email);
      final userData = await user.get();
      if (userData.exists) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
    }
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> usersData(email) {
    try {
      return fbInstance.doc(email).get();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  // ========== Chat Data Function =============
  static String getChatId(String id1, String id2) {
    return id1.compareTo(id2) < 0 ? '${id1}$id2' : '${id2}$id1';
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> chatData(
    myEmail,
    otherEmail,
  ) {
    try {
      final roomId = getChatId(myEmail, otherEmail);
      return fbInstance.doc(roomId).snapshots();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  // Chat Send Function

  static Future chatSendFuntion(data) async {
    final roomId = getChatId(data["senderEmail"], data["receiverEmail"]);
    try {
      final roomRef = fbInstanceMessage.doc(roomId);
      await roomRef.set({
        "users": [data["senderEmail"], data["receiverEmail"]],
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await roomRef.collection("userSms").add(data);
    } catch (err) {
      log(err.toString());
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchUserChat(
    myEmail,
    otherEmail,
  ) {
    final roomId = getChatId(myEmail, otherEmail);
    try {
      return fbInstanceMessage
          .doc(roomId)
          .collection("userSms")
          .orderBy("time", descending: true)
          .snapshots();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  // ======== RealTime DataBase Online Check==========

  // ============== My Chat Contact Data ==============

  static Stream<QuerySnapshot> myContectEmails(myEmail) {
    try {
      return FirebaseFirestore.instance
          .collection('messages')
          .where('users', arrayContains: myEmail)
          .snapshots();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> lastMessageStream(
    String myEmail,
    otherEmail,
  ) {
    try {
      final roomId = getChatId(myEmail, otherEmail);
      return fbInstanceMessage
          .doc(roomId)
          .collection("userSms")
          .orderBy("time", descending: true)
          .limit(1)
          .snapshots();
    } catch (err) {
      log(err.toString());
      rethrow;
    }
  }


  
}
