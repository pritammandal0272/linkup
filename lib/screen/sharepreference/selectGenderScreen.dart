import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/sharepreference/selectDob.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({super.key});

  @override
  State<SelectGenderScreen> createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState extends State<SelectGenderScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    final loginGetx = Get.find<MainController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(top: 40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(192, 249, 197, 236), // Soft Pink (Top)
                Color(0xFFA0F1FA), // Icy Cyan (Middle)
                Color(0xFFCDC3FA), // Lavender (Bottom)
              ],
              stops: [0.0, 0.5, 1.0], // Ensures even distribution
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -10,
                child: SizedBox(
                  child: Row(
                    spacing: mediaQuary.width * 0.2,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("😎", style: TextStyle(fontSize: 35)),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🥰", style: TextStyle(fontSize: 35)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.020,
                child: SizedBox(
                  child: Row(
                    spacing: mediaQuary.width * 0.6,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🙇‍♂️", style: TextStyle(fontSize: 35)),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🙇", style: TextStyle(fontSize: 35)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.070,
                child: SizedBox(
                  child: Row(
                    spacing: mediaQuary.width * 0.2,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🫣", style: TextStyle(fontSize: 35)),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🙄", style: TextStyle(fontSize: 35)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.020,
                child: SizedBox(
                  child: Column(
                    spacing: mediaQuary.height * 0.005,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🙈", style: TextStyle(fontSize: 35)),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("🙊", style: TextStyle(fontSize: 35)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.150,
                child: SizedBox(
                  child: Row(
                    spacing: mediaQuary.width * 0.4,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("💝", style: TextStyle(fontSize: 35)),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Text("💌", style: TextStyle(fontSize: 35)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.12,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 132, 204, 241),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: AssetImage("assets/appicon.png"),
                          ),
                        ),
                      ),
                      GradientText(
                        'LinkUp',
                        style: GoogleFonts.pacifico(
                          fontSize: 50,
                        ), // You still need google_fonts
                        colors: [Colors.purple, Colors.blue, Colors.cyan],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: mediaQuary.width - 20,
                        child: Text(
                          "Select your gender to get a better, more relevant experience.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: mediaQuary.height * 0.55,
                child: SizedBox(
                  child: Column(
                    spacing: 13,
                    children: [
                      Text(
                        "How do you identify yourself ?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(
                        () => Row(
                          spacing: 15,
                          children: [
                            GestureDetector(
                              onTap: () {
                                loginGetx.selectGender.value = "Male";
                              },
                              child: Container(
                                width: mediaQuary.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                  border: loginGetx.selectGender.value == "Male"
                                      ? Border.all(width: 3, color: Colors.blue)
                                      : null,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: const Color.fromARGB(
                                        110,
                                        96,
                                        125,
                                        139,
                                      ),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("👦", style: TextStyle(fontSize: 60)),
                                    Text(
                                      "I'm Male",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                loginGetx.selectGender.value = "female";
                              },
                              child: Container(
                                width: mediaQuary.width * 0.4,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      loginGetx.selectGender.value == "female"
                                      ? Border.all(width: 3, color: Colors.blue)
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: const Color.fromARGB(
                                        110,
                                        96,
                                        125,
                                        139,
                                      ),
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("👧", style: TextStyle(fontSize: 60)),
                                    Text(
                                      "I'm female",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          loginGetx.selectGender.value = "non-binary";
                          log(loginGetx.selectGender.value.toString());
                        },
                        child: Obx(
                          () => Container(
                            width: mediaQuary.width * 0.83,
                            decoration: BoxDecoration(
                              border:
                                  loginGetx.selectGender.value == "non-binary"
                                  ? Border.all(width: 3, color: Colors.blue)
                                  : null,

                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  color: const Color.fromARGB(
                                    110,
                                    96,
                                    125,
                                    139,
                                  ),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "I'm non-binary",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                child: SizedBox(
                  width: mediaQuary.width * 0.9,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => SelectDob(),
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
                          "Continue Next",
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
              ),
            ],
          ),
        ),
      ),
    );
  
  }
}
