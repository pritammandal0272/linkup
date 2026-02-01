import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  // LoginScreen Controller
  RxBool passwordFlag = false.obs;
  RxBool confirmPasswordFlag = false.obs;
  RxBool loginFlag = false.obs;
  RxBool emailDataFlag = false.obs;
  RxString selectGender = "Male".obs;
  Rx<DateTime> userDob = DateTime(2000, 1, 1).obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  Rxn<XFile> imageProfile = Rxn<XFile>();
  RxBool loginLoader = false.obs;

  // Chat HomePage Contact
  RxList contectRoomData = [].obs;
  RxString myUserId = "".obs;

  // ===========================  User Online or Offline ===========
  String emailToId(String email) {
    return email.replaceAll('.', '_');
  }

  @override
  void onReady() async {
    super.onReady();

    final sp = await SharedPreferences.getInstance();
    final myEmail = sp.getString("myEmail") ?? "";
    if (myEmail.isNotEmpty) {
      myUserId.value = myEmail;

      final String myId = emailToId(myEmail);
      final DatabaseReference statusRef = FirebaseDatabase.instance.ref(
        "status/$myId",
      );

      statusRef.set({"state": "online", "lastSeen": ServerValue.timestamp});

      statusRef.onDisconnect().set({
        "state": "offline",
        "lastSeen": ServerValue.timestamp,
      });

      markMessagesAsDelivered(myEmail);
    }
  }

  // Chat Screen Streams & Futures
  Stream<bool> userOnlineStream(String email) {
    final userId = emailToId(email);

    return FirebaseDatabase.instance.ref("status/$userId").onValue.map((event) {
      if (!event.snapshot.exists) return false;
      final data = event.snapshot.value as Map;
      return data["state"] == "online";
    });
  }

  Future<bool> getUserOnlineStatus(String email) async {
    final userId = emailToId(email);
    final snapshot = await FirebaseDatabase.instance
        .ref("status/$userId")
        .get();

    if (!snapshot.exists) return false;

    final data = snapshot.value as Map<dynamic, dynamic>?;
    if (data == null) return false;

    return data["state"] == "online";
  }

  // ================= Mark Messages as Delivered Logic (Fixed) =================
  static Future<void> markMessagesAsDelivered(String myEmail) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('userSms')
          .where('receiverEmail', isEqualTo: myEmail)
          .where('isDelivered', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var i = 0; i < querySnapshot.docs.length; i += 500) {
          final batch = FirebaseFirestore.instance.batch();
          var end = (i + 500 < querySnapshot.docs.length)
              ? i + 500
              : querySnapshot.docs.length;
          var chunk = querySnapshot.docs.sublist(i, end);

          for (var doc in chunk) {
            batch.update(doc.reference, {'isDelivered': true});
          }

          await batch.commit();
        }
      } else {
        log("No pending undelivered messages found.");
      }
    } catch (e) {
      log("Error updating delivery status: $e");
    }
  }

  // Mark Messages as Seen Logic
  static Future<void> markMessagesAsSeen(
    String myEmail,
    String senderEmail,
  ) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('userSms')
          .where('receiverEmail', isEqualTo: myEmail)
          .where('senderEmail', isEqualTo: senderEmail)
          .where('isSeen', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final batch = FirebaseFirestore.instance.batch();

        for (var doc in querySnapshot.docs) {
          batch.update(doc.reference, {'isSeen': true, 'isDelivered': true});
        }

        await batch.commit();
      }
    } catch (e) {
      log("Error updating seen status: $e");
    }
  }
}
