import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';
import '../services/auth/phone_auth.dart';
import '../services/auth/google_sign_in_auth.dart';
import '../views/loading_screen.dart';
import '../views/sign_in_view.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  PhoneAuth phoneAuth = Get.put(PhoneAuth());
  GoogleSignInAuth googleSignInAuth = Get.put(GoogleSignInAuth());
  LoadingScreen loadingScreen = Get.put(const LoadingScreen());
  double width = Get.mediaQuery.size.width;
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          Fluttertoast.showToast(msg: 'Press back again to exit', fontSize: 17);
          return false;
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return false;
        }
      },
      child: GetX<AuthController>(
          init: AuthController(),
          builder: (myController) {
            return myController.isGoogleLoading.value == false
                ? Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        "Welcome to",
                        style: TextStyle(color: Colors.black),
                      ),
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Colors.white,
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Image.asset(
                              "assets/images/app_logo.png",
                            ),
                          ),
                          Form(
                              key: _formKey,
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 200),
                                crossFadeState:
                                    myController.otpSent.value == false
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                firstChild: AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 200),
                                  crossFadeState:
                                      myController.isLoading.value == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                  firstChild: Column(
                                    children: [
                                      RichText(
                                          text: const TextSpan(
                                              text: "Please Enter Your ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: "Phone Number",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                          ])),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/india.png",
                                                        width: 35,
                                                        height: 35),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      "+91",
                                                    ),
                                                    const Icon(
                                                        Icons.arrow_drop_down),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                    color: Colors.blue,
                                                  )),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors.blue,
                                                          )),
                                                  hintText:
                                                      "Ex : \"9777865959\"",
                                                ),
                                                onSaved: (val) {
                                                  myController
                                                      .assignPhoneNumber(val!);
                                                },
                                                validator: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return 'Please enter a number';
                                                  } else {
                                                    if (val.length > 10 ||
                                                        val.length < 10) {
                                                      return 'Number exceeds 10 digits';
                                                    }
                                                    return null;
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.phone,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 1,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: const Icon(
                                                    Icons.arrow_right_alt,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    phoneAuth.phoneAuth(
                                                        myController
                                                            .phoneNumber.value);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: const TextSpan(
                                              text: "To continue to ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: "Aama Samaj ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                            TextSpan(
                                              text: "App",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ])),
                                    ],
                                  ),
                                  secondChild: SizedBox(
                                    height: 100,
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text: const TextSpan(
                                                text: "",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                              TextSpan(
                                                  text: "Please Wait ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text:
                                                      "while we send you the ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text: "OTP",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                            ])),
                                        const CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                ),
                                secondChild: AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 200),
                                  crossFadeState:
                                      myController.isLoading.value == false
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                  firstChild: Column(
                                    children: [
                                      RichText(
                                          text: const TextSpan(
                                              text: "Please Enter the ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: "OTP",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                            TextSpan(
                                              text:
                                                  " sent to your Mobile Number",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ])),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: TextField(
                                                controller:
                                                    textEditingController,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                    color: Colors.blue,
                                                  )),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Colors.blue,
                                                          )),
                                                  hintText: "Enter the OTP",
                                                ),
                                                keyboardType:
                                                    TextInputType.phone,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              flex: 1,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.blue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30))),
                                                child: const Icon(
                                                    Icons.arrow_right_alt,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  phoneAuth
                                                      .authenticatePhoneUser(
                                                          textEditingController
                                                              .text);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RichText(
                                          text: const TextSpan(
                                              text: "To continue to ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                            TextSpan(
                                                text: "Shrimpy ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                            TextSpan(
                                              text: "App",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ])),
                                    ],
                                  ),
                                  secondChild: SizedBox(
                                    height: 100,
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                            text: const TextSpan(
                                                text: "",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                              TextSpan(
                                                  text: "Please Wait ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text: "while we ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text: "Sign ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text: "you in",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ])),
                                        const CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: const <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                    flex: 1, child: Center(child: Text("or"))),
                                Expanded(
                                  flex: 2,
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Login In With",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => EmailPageView().getEmailPageView());
                                },
                                child: Image.asset("assets/images/mail.png",
                                    width: 35, height: 35),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    googleSignInAuth.signInWithGoogle();
                                  },
                                  child: SvgPicture.asset(
                                      "assets/svg/google.svg",
                                      width: 35,
                                      height: 35)),
                              SvgPicture.asset("assets/svg/facebook.svg",
                                  width: 35, height: 35),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Lottie.asset(
                            "assets/lottie/hello.json",
                            repeat: true,
                            height: size.height * 0.3,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                : loadingScreen;
          }),
    );
  }
}
