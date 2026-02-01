import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/homeScreen.dart';
import 'package:linkup/screen/sharepreference/selectGenderScreen.dart';
import 'package:linkup/screen/sharepreference/signInScreen.dart';
import 'package:linkup/screen/sharepreference/wellcomeingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initFunction();
    super.initState();
  }

  void initFunction() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final onBoardingScreen = sp.getBool("onBoardingScreen") ?? false;
    final isUserLogedIn = sp.getBool("logedinUser") ?? false;
    final userInfoScreens = sp.getBool("userInfoScreens") ?? false;
    final myEmail = sp.getString("myEmail");
     final getx = Get.put(MainController());
    if (onBoardingScreen) {
      if (isUserLogedIn) {
        if (userInfoScreens) {
          Timer(Duration(seconds: 2), () {
            Get.to(
              () => HomeScreen(myEmail: myEmail),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            );
          });
        } else {
          Timer(Duration(seconds: 2), () {
            Get.to(
              () => SelectGenderScreen(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            );
          });
        }
      } else {
        Timer(Duration(seconds: 2), () {
          Get.to(
            () => SigninScreen(),
            transition: Transition.rightToLeftWithFade,
            duration: Duration(milliseconds: 400),
          );
        });
      }
    } else {
      Timer(Duration(seconds: 2), () {
        Get.to(
          () => WellcomeingScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 400),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(top: mediaQuary.height * 0.25),
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
                top: mediaQuary.height * 0.120,
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
                        'Welcome to',
                        style: GoogleFonts.outfit(
                          fontSize: 30,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [Colors.purple, Colors.blue, Colors.cyan],
                      ),

                      GradientText(
                        'LinkUp',
                        style: GoogleFonts.pacifico(
                          fontSize: 50,
                          height: 1,
                        ), // You still need google_fonts
                        colors: [Colors.purple, Colors.blue, Colors.cyan],
                      ),
                      SizedBox(height: 10),
                      SpinKitPulse(color: Colors.cyan),
                    ],
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
