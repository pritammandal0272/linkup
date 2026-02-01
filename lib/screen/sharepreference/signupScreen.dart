import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linkup/controller/getxController.dart';
import 'package:linkup/screen/controller/screenController.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

final TextEditingController _confirmPasswordController =
    TextEditingController();
final TextEditingController _passwordController = TextEditingController();

final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

class _SignupScreenState extends State<SignupScreen> {
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(top: 30),
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
          child: Column(
            children: [
              SizedBox(
                height: loginGetx.loginFlag.value
                    ? mediaQuary.height * 0.32
                    : mediaQuary.height * 0.25,
                child: Obx(
                  () => Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: !loginGetx.loginFlag.value
                            ? -10
                            : mediaQuary.height * 0.010,
                        child: SizedBox(
                          child: Row(
                            spacing: mediaQuary.width * 0.2,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "😎",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "🥰",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: !loginGetx.loginFlag.value
                            ? mediaQuary.height * 0.020
                            : mediaQuary.height * 0.060,
                        child: SizedBox(
                          child: Row(
                            spacing: mediaQuary.width * 0.6,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "🙇‍♂️",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "🙇",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: !loginGetx.loginFlag.value
                            ? mediaQuary.height * 0.016
                            : mediaQuary.height * 0.055,
                        child: SizedBox(
                          child: Column(
                            spacing: mediaQuary.height * 0.020,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "🙈",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "🙊",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: !loginGetx.loginFlag.value
                            ? mediaQuary.height * 0.110
                            : mediaQuary.height * 0.150,
                        child: SizedBox(
                          child: Row(
                            spacing: mediaQuary.width * 0.4,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "💝",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Text(
                                  "💌",
                                  style: TextStyle(fontSize: 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: !loginGetx.loginFlag.value
                            ? mediaQuary.height * 0.040
                            : mediaQuary.height * 0.080,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      255,
                                      132,
                                      204,
                                      241,
                                    ),
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
                                  fontSize: 40,
                                ), // You still need google_fonts
                                colors: [
                                  Colors.purple,
                                  Colors.blue,
                                  Colors.cyan,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        Obx(
                          () => loginGetx.loginFlag.value
                              ? SizedBox(height: 45)
                              : SizedBox(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Obx(
                              () => GradientText(
                                !loginGetx.loginFlag.value
                                    ? "Create Account"
                                    : 'Welcome Back',
                                style: GoogleFonts.outfit(
                                  // or stick to Fredoka/Quicksand
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.purple,
                                  Colors.blue,
                                  Colors.cyan,
                                ],
                              ),
                            ),
                            Text(
                              !loginGetx.loginFlag.value
                                  ? "Sign up to get started"
                                  : 'Login to your account',
                              style: GoogleFonts.outfit(
                                // or stick to Fredoka/Quicksand
                                fontSize: 16,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => !loginGetx.loginFlag.value
                              ? SizedBox(height: 15)
                              : SizedBox(),
                        ),
                        Form(
                          key: fromKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          child: Column(
                            spacing: 13,
                            children: [
                              Obx(
                                () => loginGetx.loginFlag.value
                                    ? SizedBox()
                                    : TextFormField(
                                        controller: loginGetx.nameController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Fill the TextBox !!";
                                          } else {
                                            return null;
                                          }
                                        },

                                        cursorColor: Colors.blue,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        autofillHints: [AutofillHints.name],
                                        decoration: InputDecoration(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                12,
                                                14,
                                                0,
                                                14,
                                              ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.red,
                                                ),
                                              ),
                                          hintText: 'Enter Full Name',
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.blueGrey,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),

                                            borderSide: BorderSide(
                                              color: const Color(0xFFFF1E6E),
                                              width: 0.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),

                              TextFormField(
                                controller: loginGetx.emailController,
                                validator: ScreenController.validatorCheck,
                                cursorColor: Colors.blue,

                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: [AutofillHints.email],
                                decoration: InputDecoration(
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    12,
                                    14,
                                    0,
                                    14,
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                  hintText: 'Email or Phone Number',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.blueGrey,
                                  ),

                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                    borderSide: BorderSide(
                                      color: const Color(0xFFFF1E6E),
                                      width: 0.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),

                              Obx(
                                () => loginGetx.loginFlag.value
                                    ? SizedBox()
                                    : TextFormField(
                                        controller: _passwordController,
                                        obscureText:
                                            loginGetx.passwordFlag.value,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Fill the TextBox !!";
                                          } else {
                                            return null;
                                          }
                                        },
                                        cursorColor: Colors.blue,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                12,
                                                14,
                                                0,
                                                14,
                                              ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.red,
                                                ),
                                              ),
                                          hintText: 'Password',
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: Colors.blueGrey,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                loginGetx.passwordFlag.value =
                                                    !loginGetx
                                                        .passwordFlag
                                                        .value,
                                            icon: Icon(
                                              loginGetx.passwordFlag.value
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color:
                                                  !loginGetx.passwordFlag.value
                                                  ? Colors.blueGrey
                                                  : Colors.blue,
                                            ),
                                          ),

                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),

                                            borderSide: BorderSide(
                                              color: const Color(0xFFFF1E6E),
                                              width: 0.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),

                              Obx(
                                () => TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText:
                                      loginGetx.confirmPasswordFlag.value,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Fill the TextBox !!";
                                    } else {
                                      return null;
                                    }
                                  },
                                  cursorColor: Colors.blue,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,

                                    contentPadding: const EdgeInsets.fromLTRB(
                                      12,
                                      14,
                                      0,
                                      14,
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: Colors.red,
                                      ),
                                    ),
                                    hintText: 'Confirm Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.blueGrey,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          loginGetx.confirmPasswordFlag.value =
                                              !loginGetx
                                                  .confirmPasswordFlag
                                                  .value,
                                      icon: Icon(
                                        loginGetx.confirmPasswordFlag.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            !loginGetx.confirmPasswordFlag.value
                                            ? Colors.blueGrey
                                            : Colors.blue,
                                      ),
                                    ),

                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),

                                      borderSide: BorderSide(
                                        color: const Color(0xFFFF1E6E),
                                        width: 0.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 0.5,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                ScreenController.signUpUser(
                                  loginGetx.nameController.text,
                                  loginGetx.emailController.text,
                                  _passwordController.text,
                                  _confirmPasswordController.text,
                                  context,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF1E6E),
                              foregroundColor: Colors.white, // Text/Icon color
                              elevation: 0, // Flat style
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5,
                                children: [
                                  Text(
                                    loginGetx.loginFlag.value
                                        ? "Sign In"
                                        : "Create Account",
                                    style: GoogleFonts.outfit(
                                      // or stick to Fredoka/Quicksand
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  loginGetx.loginLoader.value
                                      ? SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Icon(Icons.arrow_forward, size: 22),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 50),
                        Column(
                          spacing: 10,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(color: Colors.blueGrey),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'or continue with',
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: mediaQuary.width - 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  ScreenController.signUpGoogleController(
                                    context,
                                    "signup",
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  // elevation: 0,
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
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
                                      'try another email',

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

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      loginGetx.loginFlag.value
                                          ? "Don’t have an account? "
                                          : 'Already have an account? ',
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      loginGetx.loginFlag.value =
                                          !loginGetx.loginFlag.value;
                                      loginGetx.nameController.clear();
                                      loginGetx.emailController.clear();
                                      _passwordController.clear();
                                      fromKey.currentState!.reset();
                                    },
                                    child: Obx(
                                      () => Text(
                                        loginGetx.loginFlag.value
                                            ? 'Sign Up'
                                            : 'Sign In',
                                        style: TextStyle(
                                          color: Color(0xFF4A90E2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
