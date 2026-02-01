import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/controller/screenController.dart';
import 'package:linkup/screen/sharepreference/signupScreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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

  final getx = Get.put(MainController());

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
                top: mediaQuary.height * 0.010,
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
                top: mediaQuary.height * 0.060,
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
                top: mediaQuary.height * 0.110,
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
                top: mediaQuary.height * 0.060,
                child: SizedBox(
                  child: Column(
                    spacing: mediaQuary.height * 0.020,
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
                top: mediaQuary.height * 0.2,
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
                top: mediaQuary.height * 0.2,
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
                      SizedBox(
                        width: mediaQuary.width - 20,
                        child: Text(
                          "\"LinkUp brings your people closer. Experience seamless, secure, and stylish messaging built for your lifestyle. Connect effortlessly, share moments instantly, and enjoy a messaging experience that’s fast, private, and fun.\"",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            color: const Color.fromARGB(185, 96, 125, 139),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: mediaQuary.width - 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            ScreenController.signUpGoogleController(
                              context,
                              "signin",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 3,
                            children: [
                              Image.asset(
                                "assets/googleLogo.png",
                                height: 30,
                                width: 30,
                              ),
                              Text(
                                'Signup With Google',

                                style: GoogleFonts.outfit(
                                  // or stick to Fredoka/Quicksand
                                  fontSize: 18,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: mediaQuary.width - 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => SignupScreen(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Sign In your Account',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
