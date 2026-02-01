import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkup/controller/database/firebaseDatbase.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/controller/googleLoginController.dart';
import 'package:linkup/screen/homeScreen.dart';
import 'package:linkup/screen/sharepreference/selectGenderScreen.dart';
import 'package:linkup/screen/sharepreference/signupScreen.dart';
import 'package:linkup/utils/widget/snakeBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenController {
  //============ Login Controller Start========================\

  static final loginGetx = Get.find<MainController>();
  static void signUpUser(
    name,
    email,
    password,
    confirmPassword,
    BuildContext context,
  ) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (loginGetx.loginFlag.value) {
      // ===== SignIn Logic==========
      final data = {"email": email, "password": confirmPassword};
      loginGetx.loginLoader.value = true;
      final result = await FirebaseDatabase.signInData(data);
      loginGetx.loginLoader.value = false;
      if (result) {
        navigateFun(context, sp, email, loginGetx.loginFlag.value);
      } else {
        loginGetx.loginLoader.value = false;
        showSnackbarFunction(
          context,
          "Email and Password Invalid",
          Colors.red,
          Icons.cancel,
        );
      }
      loginGetx.loginLoader.value = false;
    } else {
      // ===== SignUp Logic==========
      if (password != confirmPassword) {
        showSnackbarFunction(
          context,
          "Confirm Password not Matched",
          Colors.red,
          Icons.info,
        );
      } else {
        final data = {
          "name": name,
          "email": email,
          "password": password,
          "gender": loginGetx.selectGender.value,
          "dob": loginGetx.userDob.toString(),
          "isOnline": false,
          "profilePic": "",
        };
        loginGetx.loginLoader.value = true;
        final result = await FirebaseDatabase.signUpInsertData(data);
        if (result) {
          loginGetx.loginLoader.value = false;
          navigateFun(context, sp, email, loginGetx.loginFlag.value);
        } else {
          loginGetx.loginLoader.value = false;
          showSnackbarFunction(
            context,
            "Server faild",
            Colors.red,
            Icons.cancel,
          );
        }
      }
    }
  }

  static navigateFun(BuildContext context, sp, email, isSignin) {
    sp.setBool("logedinUser", true);
    sp.setString("myEmail", email);
    final userInfoScreens = sp.getBool("userInfoScreens") ?? false;
    if (isSignin) {
      sp.setBool("userInfoScreens", true);
      Get.offAll(
        () => HomeScreen(myEmail: email),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 400),
      );
      showSnackbarFunction(
        context,
        "Login Successfully",
        Colors.blue,
        Icons.check_circle_outline,
      );
      return;
    }
    if (!userInfoScreens) {
      Get.offAll(
        () => SelectGenderScreen(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 400),
      );
      showSnackbarFunction(
        context,
        "Please upload your info...",
        Colors.blue,
        Icons.check_circle_outline,
      );
    } else {
      Get.offAll(
        () => HomeScreen(myEmail: email),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 400),
      );
      showSnackbarFunction(
        context,
        "Account Create Successfully",
        Colors.blue,
        Icons.check_circle_outline,
      );
    }
  }

  static String? validatorCheck(value) {
    final emailCheck = !RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(value.trim());
    final phCheck = !RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim());
    if (emailCheck && phCheck) {
      return "Enter valid email or mobile number !!";
    } else {
      return null;
    }
  }

  static void signUpGoogleController(BuildContext context, type) async {
    final data = await GoogleLoginService().signInWithGoogleEmail();

    if (data == null) {
      showSnackbarFunction(
        context,
        "Email choose Failed",
        Colors.red,
        Icons.cancel,
      );
    } else {
      final bool checkEmailExits = await FirebaseDatabase.checkUserExists(
        data.email,
      );
      log(checkEmailExits.toString());
      if (checkEmailExits) {
        showSnackbarFunction(
          context,
          "Email id allready exits..\ntry another email..",
          Colors.red,
          Icons.cancel,
        );
      } else {
        if (type == "signin") {
          Get.to(
            () => SignupScreen(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 400),
          );
        }
        loginGetx.emailController.text = data.email;
        loginGetx.nameController.text = data.displayName;
        showSnackbarFunction(
          context,
          "Now Set your Secret Password",
          Colors.blue,
          Icons.info,
        );
      }
    }
    GoogleLoginService().logout();
  }

  //============ Login Controller End========================

  // ============ Chat Send Function Start ==============

  static void sendSms(senderEmail, receiverEmail, text) async {
    final onlineCheck = await loginGetx.getUserOnlineStatus(receiverEmail);
    final time = DateTime.now();
    final data = {
      "senderEmail": senderEmail,
      "receiverEmail": receiverEmail,
      "text": text,
      "time": time,
      "isSent": true,
      "isDelivered": onlineCheck,
      "isSeen": false,
    };
    log(data.toString());
    FirebaseDatabase.chatSendFuntion(data);
  }

  // ============ Chat Send Function End ==============
}
