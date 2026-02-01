import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import this for SchedulerBinding
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linkup/controller/database/firebaseDatbase.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/controller/screenController.dart';
import 'package:linkup/utils/widget/snakeBar.dart';

class ChatDetailScreen extends StatefulWidget {
  final myEmail;
  final otherEmail;
  final userName;
  const ChatDetailScreen({
    super.key,
    required this.myEmail,
    required this.otherEmail,
    required this.userName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController userChatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  static final loginGetx = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
    initFunction();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 250), () {
          _scrollToBottom(animate: true);
        });
      }
    });
  }

  void initFunction() async {
    await MainController.markMessagesAsSeen(widget.myEmail, widget.otherEmail);
  }

  void _scrollToBottom({bool animate = true}) {
    // Wait until the next frame (list fully rendered)
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final position = _scrollController.position.maxScrollExtent;
        if (animate) {
          _scrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        } else {
          _scrollController.jumpTo(position);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFD1E3), Color(0xFFD1F0FF)],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              // --- HEADER ---
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 35,
                  bottom: 12,
                ),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFD1E3), Color(0xFFD1F0FF)],
                  ),

                  border: Border(
                    bottom: BorderSide(color: Colors.blueGrey.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.purpleAccent],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Icon(Icons.person, color: Colors.white, size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          StreamBuilder<bool>(
                            stream: loginGetx.userOnlineStream(
                              widget.otherEmail,
                            ),
                            builder: (context, snapshot) {
                              final isOnline = snapshot.data ?? false;
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: isOnline
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  Text(isOnline ? "Online" : "Offline"),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- CHAT LIST ---
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseDatabase.fetchUserChat(
                    widget.myEmail,
                    widget.otherEmail,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Center(child: Text("Something went wrong")),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return _buildNoChatFoundWidget();
                    }

                    final data = snapshot.data!.docs.reversed.toList();

                    // 3. Auto-scroll when new data comes
                    _scrollToBottom(animate: true);

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: data.length,
                      // Add padding at bottom so last message isn't hidden
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final userSms = data[index].data();
                        log(userSms.toString());
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              userSms["senderEmail"] == widget.myEmail
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(width: 40),
                                          Flexible(
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft: Radius.circular(
                                                    20,
                                                  ),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    userSms["text"],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        chatTimeFormat(
                                                          userSms["time"],
                                                        ),
                                                        style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4),
                                                      smsStatusFunction(
                                                        userSms,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.white54,
                                            child: Icon(
                                              Icons.person,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Flexible(
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight: Radius.circular(
                                                    20,
                                                  ),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                userSms["text"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // --- INPUT FIELD ---
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  border: Border(
                    top: BorderSide(color: Colors.white.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  spacing: 5,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Form(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hint: Text(
                                  "Type a message...",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              focusNode: _focusNode,
                              controller: userChatController,
                              cursorColor: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (userChatController.text.isNotEmpty) {
                          ScreenController.sendSms(
                            widget.myEmail,
                            widget.otherEmail,
                            userChatController.text,
                          );
                          userChatController.clear();
                          // 4. Scroll after sending
                          _scrollToBottom(animate: true);
                        } else {
                          showSnackbarFunction(
                            context,
                            "Enter text on TextField....",
                            Colors.red,
                            Icons.info,
                          );
                        }
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(95, 255, 64, 128),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(Icons.send, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoChatFoundWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.mark_chat_unread_rounded,
                size: 70,
                color: Colors.purple.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "No Messages Yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Don't be shy! Send the first message and start the conversation with ${widget.otherEmail.split('@')[0]}.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: InkWell(
                onTap: () {
                  ScreenController.sendSms(
                    widget.myEmail,
                    widget.otherEmail,
                    "hello 👋",
                  );
                  userChatController.clear();
                  _scrollToBottom(animate: true);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.touch_app_rounded,
                      color: Colors.black54,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Type below to say hello 👋",
                      style: TextStyle(
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
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
      return Icon(Icons.done_all, size: 14, color: Colors.white);
    } else if (lastChat["isSent"] == true) {
      return Icon(Icons.done, size: 14, color: Colors.white);
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
