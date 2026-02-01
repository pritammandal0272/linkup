import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/sharepreference/selectUserProfilePhoto.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SelectDob extends StatefulWidget {
  const SelectDob({super.key});

  @override
  State<SelectDob> createState() => _SelectDobState();
}

class _SelectDobState extends State<SelectDob> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuary = MediaQuery.of(context).size;
    final loginGetx = Get.find<MainController>();

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(top: 40),
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
                top: 0,
                child: Container(
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
              ),
              Positioned(
                top: mediaQuary.height * 0.060,
                child: SizedBox(
                  child: Row(
                    spacing: mediaQuary.width * 0.6,
                    children: const [
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
                    children: const [
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
                    children: const [
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
                    children: const [
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
                top: mediaQuary.height * 0.178,
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                          image: const DecorationImage(
                            image: AssetImage("assets/appicon.png"),
                          ),
                        ),
                      ),
                      GradientText(
                        'LinkUp',
                        style: GoogleFonts.pacifico(fontSize: 50),
                        colors: const [Colors.purple, Colors.blue, Colors.cyan],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: mediaQuary.width - 20,
                        child: const Text(
                          "Your Birthday",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                child: SizedBox(
                  width: mediaQuary.width * 0.9,
                  child: buildInlineDatePicker(
                    selectedDate: loginGetx.userDob,
                    onDateChanged: (newDate) {
                      loginGetx.userDob.value = newDate;
                    },
                  ),
                ),
              ),
              Positioned(
                top: -5,
                left: 20,
                child: InkWell(
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
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    width: mediaQuary.width * 0.90,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => SelectUserProfilephoto(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildInlineDatePicker({
  required Rx<DateTime> selectedDate,
  required ValueChanged<DateTime> onDateChanged,
}) {
  return Obx(
    () => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            "Date of Birth",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM d, yyyy').format(selectedDate.value),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.keyboard_arrow_up, color: Colors.blueAccent),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 200,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate.value,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: onDateChanged,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
