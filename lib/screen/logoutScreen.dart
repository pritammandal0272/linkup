import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/screen/sharepreference/signInScreen.dart';
import 'package:linkup/screen/sharepreference/signupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(133, 249, 168, 212), Color(0xFFE3F8FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              // 2. Profile
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              //   child: Row(
              //     spacing: 10,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Get.back();
              //         },
              //         child: Icon(
              //           Icons.arrow_back_ios_new,
              //           size: 20,
              //           color: Colors.black87,
              //         ),
              //       ),
              //       Container(
              //         width: 52,
              //         height: 52,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           border: Border.all(color: Colors.white, width: 2),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black.withOpacity(0.05),
              //               blurRadius: 4,
              //               offset: Offset(0, 2),
              //             ),
              //           ],
              //         ),
              //         child: Container(
              //           height: 160,
              //           width: 160,
              //           decoration: BoxDecoration(
              //             color: Color.fromRGBO(93, 108, 245, 1),
              //             borderRadius: BorderRadius.circular(300),
              //           ),
              //           child: Icon(
              //             Icons.person,
              //             size: 30,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),

              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Alex Johnson",
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.w700,
              //               color: Color(0xFF1E293B), // Slate 800
              //             ),
              //           ),
              //           Text(
              //             "View Profile",
              //             style: TextStyle(
              //               fontSize: 12,
              //               color: Colors.grey[600],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Spacer(flex: 2),
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Glow effect
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    Text("🙈", style: TextStyle(fontSize: 96)),
                    Positioned(
                      top: 20,
                      right: 30,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: Text("💔", style: TextStyle(fontSize: 32)),
                      ),
                    ),
                    // Crying Face
                    Positioned(
                      bottom: 30,
                      left: 30,
                      child: Text("😢", style: TextStyle(fontSize: 28)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF9333EA), // Purple 600
                          Color(0xFF3B82F6), // Blue 500
                        ],
                      ).createShader(bounds),
                      child: Text(
                        "Leaving so soon?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Color(0xFF475569), // Slate 600
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: "Are you sure you want to log out\nfrom ",
                          ),
                          TextSpan(
                            text: "LinkUp",
                            style: TextStyle(
                              color: Color(0xFF3B82F6), // Blue 500
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "? Your matches will\nmiss you!"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
                child: Column(
                  children: [
                    SizedBox(
                      width: mediaQuary.width * 0.9,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setBool("logedinUser", false);
                          await sp.setBool("userInfoScreens", false);
                          Get.deleteAll(force: true);
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
                              "Log Out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.logout, color: Colors.white, size: 22),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF64748B), // Slate 500
                      ),
                      child: Text(
                        "Cancel, I'm staying!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: 130,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
