import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkup/controller/database/firebaseDatbase.dart';
import 'package:linkup/screen/chatScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart' as real_db;

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    initFunction();
    super.initState();
  }

  late SharedPreferences sp;
  var myEmail = "";
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  void initFunction() async {
    sp = await SharedPreferences.getInstance();
    myEmail = sp.getString("myEmail") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black87,
          ),
        ),
        title: Text(
          "New Chat",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(133, 249, 168, 212),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(133, 249, 168, 212), Color(0xFFD1F0FF)],
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextFormField(
                  controller: searchController,

                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search by User Name...",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Divider(height: 0.5, color: const Color.fromARGB(69, 96, 125, 139)),
            StreamBuilder(
              stream: FirebaseDatabase.allUsersData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(child: Text("Something went wrong")),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(child: Text("No users found")),
                  );
                }

                final data = snapshot.data!.docs;
                final allUsers = snapshot.data!.docs;
                final filteredUsers = allUsers.where((doc) {
                  final userData = doc.data();
                  final email = userData["email"].toString();
                  final name = userData["name"].toString().toLowerCase();
                  if (email == myEmail) return false;
                  return name.contains(searchQuery);
                }).toList();

                if (filteredUsers.isEmpty) {
                  return noDataFound();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final userData = data[index];
                    final bool myEmailFlag = myEmail == userData["email"];
                    return myEmailFlag
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                  () => ChatDetailScreen(
                                    myEmail: myEmail,
                                    otherEmail: userData["email"],
                                    userName: userData["name"],
                                  ),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 400),
                                );
                              },
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFC084FC),
                                              Color(0xFF6366F1),
                                            ], // Purple to Indigo
                                          ),
                                          image: userData["profilePic"] != ""
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                    userData["profilePic"],
                                                  ),
                                                )
                                              : null,
                                        ),
                                        alignment: Alignment.center,
                                        child: userData["profilePic"] == ""
                                            ? Text(
                                                userData["name"][0].toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : null,
                                      ),
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
                                                    .replaceAll('.', '_'),
                                              )
                                              .onValue,
                                          builder: (context, statusSnapshot) {
                                            bool isUserOnline = false;

                                            if (statusSnapshot.hasData &&
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
                                              decoration: BoxDecoration(
                                                color: isUserOnline
                                                    ? Colors.green
                                                    : Colors.grey,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
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
                                                  userData["name"].toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),

                                                // Time
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  userData["gender"],
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: Colors.grey,
                                          size: 16,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget noDataFound() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.person_search_rounded, // অথবা Icons.search_off_rounded
                size: 80,
                color: const Color(0xFFFF3B8E).withOpacity(0.6),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "No User Found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A).withOpacity(0.8),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "We couldn't find any user matching \"$searchQuery\".\nTry checking the spelling.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 50), // Bottom spacing for center alignment
          ],
        ),
      ),
    );
  }
}
