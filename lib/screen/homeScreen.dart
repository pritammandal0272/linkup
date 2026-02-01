import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:linkup/controller/database/dummyData.dart';
import 'package:linkup/controller/database/firebaseDatbase.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/chatScreen.dart';
import 'package:linkup/screen/contactList.dart';
import 'package:linkup/screen/logoutScreen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_database/firebase_database.dart' as real_db;

class HomeScreen extends StatefulWidget {
  final myEmail;
  const HomeScreen({super.key, required this.myEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final homeScreenGetx = Get.find<MainController>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initFunctionCall();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.initState();
  }

  String myEmail = "";
  void initFunctionCall() async {
    homeScreenGetx.contectRoomData.clear();
    var listData = await DummyData.userContectdata();
    homeScreenGetx.contectRoomData.addAll(listData);

    log(myEmail.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(133, 249, 168, 212), Color(0xFFA0F1FA)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText(
                      'LinkUp',
                      style: GoogleFonts.pacifico(fontSize: 37),
                      colors: [Colors.purple, Colors.blue, Colors.cyan],
                    ),

                    Row(
                      spacing: 10,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          child: Icon(Icons.search, color: Colors.black87),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => LogoutScreen(),
                              transition: Transition.rightToLeftWithFade,
                              duration: Duration(milliseconds: 400),
                            );
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            child: Icon(
                              Icons.settings_outlined,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // Padding(
              //   padding: EdgeInsets.only(left: 15, bottom: 5, top: 7),
              //   child: Text(
              //     "STROIES",
              //     style: TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //       color: Color(0xFF475569),
              //       letterSpacing: 1.0,
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   padding: EdgeInsets.only(left: 15, right: 15),
              //   child: Row(
              //     spacing: 10,
              //     children: [
              //       Column(
              //         spacing: 5,
              //         children: [
              //           DottedBorder(
              //             options: CircularDottedBorderOptions(
              //               color: Colors.black,
              //               strokeWidth: 2,
              //               dashPattern: const [6, 3],
              //             ),
              //             child: Container(
              //               child: CircleAvatar(
              //                 backgroundColor: Colors.white,
              //                 radius: 30,
              //                 child: Icon(
              //                   Icons.add,
              //                   color: Colors.black,
              //                   size: 30,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Text("Your Story"),
              //         ],
              //       ),
              //       Column(
              //         spacing: 5,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 2,
              //                 color: const Color.fromARGB(255, 1, 140, 255),
              //               ),
              //               borderRadius: BorderRadius.circular(300),
              //             ),
              //             child: CircleAvatar(
              //               backgroundImage: AssetImage("assets/appicon.png"),
              //               radius: 30,
              //             ),
              //           ),
              //           Text("Pritam"),
              //         ],
              //       ),

              //       Column(
              //         spacing: 5,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 2,
              //                 color: const Color.fromARGB(255, 1, 140, 255),
              //               ),
              //               borderRadius: BorderRadius.circular(300),
              //             ),
              //             child: CircleAvatar(
              //               backgroundImage: AssetImage("assets/appicon.png"),
              //               radius: 30,
              //             ),
              //           ),
              //           Text("Madhab"),
              //         ],
              //       ),

              //       Column(
              //         spacing: 5,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 2,
              //                 color: const Color.fromARGB(255, 1, 140, 255),
              //               ),
              //               borderRadius: BorderRadius.circular(300),
              //             ),
              //             child: CircleAvatar(
              //               backgroundImage: AssetImage("assets/appicon.png"),
              //               radius: 30,
              //             ),
              //           ),
              //           Text("Abhinandan"),
              //         ],
              //       ),

              //       Column(
              //         spacing: 5,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                 width: 2,
              //                 color: const Color.fromARGB(255, 1, 140, 255),
              //               ),
              //               borderRadius: BorderRadius.circular(300),
              //             ),
              //             child: CircleAvatar(
              //               backgroundImage: AssetImage("assets/appicon.png"),
              //               radius: 30,
              //             ),
              //           ),
              //           Text("Abhinandan"),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 55,
              //     child: ElevatedButton(
              //       onPressed: () {},
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Color(0xFFFF1E6E),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(16),
              //         ),
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 10,
              //           vertical: 10,
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             spacing: 5,
              //             children: [
              //               Icon(Icons.bolt, color: Colors.white, size: 30),
              //               Text(
              //                 "Start Random Chat",
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               SizedBox(width: 8),
              //             ],
              //           ),
              //           Icon(Icons.arrow_forward_ios, color: Colors.white),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text(
                        "Recent Messages",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: FirebaseDatabase.myContectEmails(
                            widget.myEmail,
                          ),
                          builder: (context, snapshotData) {
                            if (!snapshotData.hasData) {
                              return Center(
                                child: SizedBox(
                                  height: 20,
                                  width: 50,
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: SpinKitPulse(color: Colors.purple),
                                  ),
                                ),
                              );
                            }
                            final users = snapshotData.data!.docs;
                            if (users.isEmpty) {
                              return _buildNoChatView();
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final data = users[index].data() as Map;
                                var otherEmail;
                                for (var element in data["users"]) {
                                  if (element != widget.myEmail) {
                                    otherEmail = element;
                                  }
                                }
                                return FutureBuilder(
                                  future: FirebaseDatabase.usersData(
                                    otherEmail,
                                  ),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(child: SizedBox());
                                    }
                                    final userData =
                                        snapshot.data!.data()
                                            as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 15.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => ChatDetailScreen(
                                              myEmail: widget.myEmail,
                                              otherEmail: otherEmail,
                                              userName: userData["name"],
                                            ),
                                            transition:
                                                Transition.rightToLeftWithFade,
                                            duration: const Duration(
                                              milliseconds: 400,
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 56,
                                                  height: 56,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18,
                                                        ),
                                                    gradient:
                                                        const LinearGradient(
                                                          colors: [
                                                            Color(0xFFC084FC),
                                                            Color(0xFF6366F1),
                                                          ], // Purple to Indigo
                                                        ),
                                                    image:
                                                        userData["profilePic"] !=
                                                            ""
                                                        ? DecorationImage(
                                                            image: AssetImage(
                                                              userData["profilePic"],
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child:
                                                      userData["profilePic"] ==
                                                          ""
                                                      ? Text(
                                                          userData["name"][0]
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                // Positioned(
                                                //   top: -4,
                                                //   right: -4,
                                                //   child: Container(
                                                //     width: 20,
                                                //     height: 20,
                                                //     decoration: BoxDecoration(
                                                //       color: const Color(
                                                //         0xFFFF3B8E,
                                                //       ),
                                                //       shape: BoxShape.circle,
                                                //       border: Border.all(
                                                //         color: Colors.white,
                                                //         width: 2,
                                                //       ),
                                                //     ),
                                                //     alignment: Alignment.center,
                                                //     // UnRead SMS Count
                                                //     child: Text(
                                                //       "1",
                                                //       style: TextStyle(
                                                //         color: Colors.white,
                                                //         fontSize: 10,
                                                //         fontWeight:
                                                //             FontWeight.bold,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: StreamBuilder(
                                                    stream: real_db
                                                        .FirebaseDatabase
                                                        .instance
                                                        .ref()
                                                        .child("status")
                                                        .child(
                                                          userData["email"]
                                                              .toString()
                                                              .replaceAll(
                                                                '.',
                                                                '_',
                                                              ),
                                                        )
                                                        .onValue,
                                                    builder: (context, statusSnapshot) {
                                                      bool isUserOnline = false;

                                                      if (statusSnapshot
                                                              .hasData &&
                                                          statusSnapshot
                                                                  .data!
                                                                  .snapshot
                                                                  .value !=
                                                              null) {
                                                        final statusMap =
                                                            statusSnapshot
                                                                    .data!
                                                                    .snapshot
                                                                    .value
                                                                as Map;
                                                        if (statusMap['state'] ==
                                                            'online') {
                                                          isUserOnline = true;
                                                        }
                                                      }

                                                      return Container(
                                                        width: 14,
                                                        height: 14,
                                                        decoration:
                                                            BoxDecoration(
                                                              color:
                                                                  isUserOnline
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2,
                                                              ),
                                                            ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                spacing: 4,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        userData["name"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      // Time
                                                      StreamBuilder(
                                                        stream:
                                                            FirebaseDatabase.lastMessageStream(
                                                              widget.myEmail,
                                                              otherEmail,
                                                            ),
                                                        builder: (context, snapshot) {
                                                          if (!snapshot
                                                                  .hasData ||
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty) {
                                                            return const Text(
                                                              "No messages",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            );
                                                          }

                                                          final lastMsg =
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .first
                                                                  .data();
                                                          return Text(
                                                            chatTimeFormat(
                                                              lastMsg["time"],
                                                            ),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      StreamBuilder(
                                                        stream:
                                                            FirebaseDatabase.lastMessageStream(
                                                              widget.myEmail,
                                                              otherEmail,
                                                            ),
                                                        builder: (context, snapshot) {
                                                          if (!snapshot
                                                                  .hasData ||
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty) {
                                                            return const Text(
                                                              "No messages",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            );
                                                          }

                                                          final lastMsg =
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .first
                                                                  .data();
                                                          return smsStatusFunction(
                                                            lastMsg,
                                                          );
                                                        },
                                                      ),

                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: StreamBuilder(
                                                          stream:
                                                              FirebaseDatabase.lastMessageStream(
                                                                widget.myEmail,
                                                                otherEmail,
                                                              ),
                                                          builder: (context, snapshot) {
                                                            if (!snapshot
                                                                    .hasData ||
                                                                snapshot
                                                                    .data!
                                                                    .docs
                                                                    .isEmpty) {
                                                              return const Text(
                                                                "No messages",
                                                                style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                              );
                                                            }

                                                            final lastMsg =
                                                                snapshot
                                                                    .data!
                                                                    .docs
                                                                    .first
                                                                    .data();

                                                            final bool isMe =
                                                                lastMsg["senderEmail"] ==
                                                                homeScreenGetx
                                                                    .myUserId
                                                                    .value;

                                                            return Text(
                                                              lastMsg["text"] ??
                                                                  "",
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: isMe
                                                                    ? Colors
                                                                          .grey
                                                                    : Colors
                                                                          .black,
                                                                fontSize: 13,
                                                                fontWeight: isMe
                                                                    ? null
                                                                    : FontWeight
                                                                          .bold,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
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
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(
              () => ContactList(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            );
          },
          backgroundColor: Color(0xFFFF3B8E),

          elevation: 2,
          shape: CircleBorder(),
          child: Icon(Icons.add_comment, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget smsStatusFunction(userData) {
    final lastChat = userData;
    if (lastChat == null) {
      return SizedBox();
    }
    final myEmail = widget.myEmail;

    if (lastChat["senderEmail"] != myEmail) {
      return SizedBox();
    }

    if (lastChat["isSeen"] == true) {
      return Icon(
        Icons.done_all,
        size: 14,
        color: const Color.fromARGB(255, 21, 0, 255),
      );
    } else if (lastChat["isDelivered"] == true) {
      return Icon(Icons.done_all, size: 14, color: Colors.grey);
    } else if (lastChat["isSent"] == true) {
      return Icon(Icons.done, size: 14, color: Colors.grey);
    }

    return SizedBox();
  }
}

String chatTimeFormat(Timestamp timestamp) {
  final DateTime date = timestamp.toDate();
  final DateTime now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final messageDate = DateTime(date.year, date.month, date.day);

  if (messageDate == today) {
    return DateFormat('hh:mm a').format(date);
  } else if (messageDate == yesterday) {
    return "Yesterday";
  } else if (date.year == now.year) {
    return DateFormat('dd MMM').format(date);
  } else {
    return DateFormat('dd MMM yyyy').format(date);
  }
}

// No Conversation Widget Function
Widget _buildNoChatView() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_chat_unread_outlined,
            size: 80,
            color: Color(0xFFFF3B8E).withOpacity(0.5),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "No Conversations Yet",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Connect with your friends and\nstart messaging now!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(height: 30),
        // Start Chat Button
        ElevatedButton.icon(
          onPressed: () {
            Get.to(
              () => ContactList(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 400),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF3B8E),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
            shadowColor: Color(0xFFFF3B8E).withOpacity(0.4),
          ),
          icon: Icon(Icons.add_comment_rounded),
          label: Text(
            "Start Chat",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 50), //Bottom spacing fix
      ],
    ),
  );
}
