import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/controller/imagePicker.dart';
import 'package:linkup/screen/homeScreen.dart';
import 'package:linkup/utils/widget/snakeBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserProfilephoto extends StatefulWidget {
  const SelectUserProfilephoto({super.key});

  @override
  State<SelectUserProfilephoto> createState() => _SelectUserProfilephotoState();
}

class _SelectUserProfilephotoState extends State<SelectUserProfilephoto> {
  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    final loginGetx = Get.find<MainController>();
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: mediaQuary.height),
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(192, 249, 197, 236),
                  Color(0xFFA0F1FA),
                  Color(0xFFCDC3FA),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color.fromARGB(110, 96, 125, 139),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.chevron_left,
                              size: 30,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: loginGetx.selectGender.value == "non-binary"
                                ? Border.all(width: 3, color: Colors.blue)
                                : null,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromARGB(110, 96, 125, 139),
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            loginGetx.selectGender.value == "non-binary"
                                ? "non-binary"
                                : loginGetx.selectGender.value == "Male"
                                ? "👦 Male"
                                : "👧 female",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            sp.setBool("userInfoScreens", true);
                           final myEmail =  sp.getString("myEmail");
                            Get.to(
                              () => HomeScreen(myEmail: myEmail,),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Container(
                            // height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: Color.fromARGB(110, 96, 125, 139),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "Skip",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(110, 96, 125, 139),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Text(
                        "🎂 ${DateFormat('MMMM d, yyyy').format(loginGetx.userDob.value).toString()}",
                        style: const TextStyle(
                          height: 1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    Text(
                      "Your Avtar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "Your profile photo helps others connect with you faster.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: Colors.white,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                var image =
                                    await GlobalImagepicker.cameraImage();
                                if (image == null) {
                                  showSnackbarFunction(
                                    context,
                                    "Faild to Uploaded",
                                    Colors.red,
                                    Icons.cancel,
                                  );
                                } else {
                                  loginGetx.imageProfile.value = image;
                                  showSnackbarFunction(
                                    context,
                                    "Uploaded Successfully",
                                    Colors.blue,
                                    Icons.check,
                                  );
                                }
                                Get.back();
                              },
                              borderRadius: BorderRadius.circular(12),
                              splashColor: Colors.pinkAccent.withOpacity(0.2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 25,
                                      color: Colors.pinkAccent,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      "Camera",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () async {
                                var image =
                                    await GlobalImagepicker.galleryImage();
                                if (image == null) {
                                  showSnackbarFunction(
                                    context,
                                    "Faild to Uploaded",
                                    Colors.red,
                                    Icons.cancel,
                                  );
                                } else {
                                  loginGetx.imageProfile.value = image;
                                  showSnackbarFunction(
                                    context,
                                    "Uploaded Successfully",
                                    Colors.blue,
                                    Icons.check,
                                  );
                                }
                                Get.back();
                              },
                              borderRadius: BorderRadius.circular(12),
                              splashColor: Colors.blueAccent.withOpacity(0.2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade100,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.photo_library_outlined,
                                      size: 25,
                                      color: Colors.blueAccent,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: DottedBorder(
                    options: CircularDottedBorderOptions(
                      color: Color.fromRGBO(93, 108, 245, 1),
                      strokeWidth: 3,
                      dashPattern: const [10, 3],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Obx(
                        () => Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(93, 108, 245, 1),
                            borderRadius: BorderRadius.circular(300),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromARGB(110, 96, 125, 139),
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: loginGetx.imageProfile.value == null
                              ? Icon(
                                  Icons.camera_alt_outlined,
                                  size: 70,
                                  color: Colors.white,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(300),
                                  child: Image.file(
                                    File(loginGetx.imageProfile.value!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  spacing: 15,
                  children: [
                    Icon(Icons.lock, color: Colors.blueGrey),
                    Text(
                      "No one will see your real photo: we do not store anything and use it only to generate an avatar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setBool("userInfoScreens", true);
                      final myEmail =  sp.getString("myEmail");
                      Get.to(
                        () => HomeScreen(myEmail: myEmail,),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF1E6E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
