import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/screen/homeScreen.dart';
import 'package:linkup/screen/sharepreference/signInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WellcomeingScreen extends StatefulWidget {
  const WellcomeingScreen({super.key});

  @override
  State<WellcomeingScreen> createState() => _WellcomeingScreenState();
}

class _WellcomeingScreenState extends State<WellcomeingScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    initFunction();
  }

  void initFunction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final logedinUser = prefs.getBool("logedinUser") ?? false;
    final myEmail =  prefs.getString("myEmail");
    // prefs.clear();
    if (logedinUser) {
      Get.offAll(
        () => HomeScreen(myEmail: myEmail,),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 400),
      );
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
                          // or stick to Fredoka/Quicksand
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
                      SizedBox(height: 5),
                      SizedBox(
                        width: mediaQuary.width * 0.9,
                        child: Text(
                          'Where conversations turn into connections. Meet, chat, and connect with people who match your vibe',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            // or stick to Fredoka/Quicksand
                            fontSize: 17,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 500,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/freepik__talk.png"),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                child: SizedBox(
                  width: mediaQuary.width * 0.9,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      await sp.setBool("onBoardingScreen", true);
                      Get.offAll(
                        () => SigninScreen(),
                        transition: Transition.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 400),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF1E6E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
