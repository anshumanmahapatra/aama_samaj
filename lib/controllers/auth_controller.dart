
import '../services/auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/storage/storage.dart';

class AuthController extends GetxController {

  var isLoading = false.obs;
  var isGoogleLoading = false.obs;
  var verificationId = "".obs;
  var phoneNumber = "".obs;
  var otpSent = false.obs;

  PageController authenticationPageController = PageController();

  String? name, email, password, confirmPassword;
  int authenticationPageNumber = 0;

  @override
  void onInit() {
    isUserLoggedIn();
    super.onInit();
  }

  changeAuthenticationPage(int pageNo) {
    authenticationPageNumber = pageNo;
    authenticationPageController.animateToPage(authenticationPageNumber,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  saveAuthField(int id, String val) {
    if (id == 1) {
      name = val;
    } else if (id == 2) {
      email = val;
    } else if (id == 3) {
      password = val;
    } else {
      confirmPassword = val;
    }
  }

  login() {
    EmailAuth().logIntoAccount(email!, password!);
  }

  register() {
    EmailAuth().createAccount(email!, name!, password!);
  }

  void assignVerificationId(String id) {
    verificationId.value = id;
  }

  void assignPhoneNumber(String number) {
    phoneNumber.value = "+91" + number;
  }

  void isOTPSent(bool val) {
    otpSent.value = val;
  }

  void showLoading(bool val) {
    isLoading.value = val;
  }

  void showGoogleLoading(bool val) {
    isGoogleLoading.value = val;
  }

  Future<bool> isUserLoggedIn() async {
    debugPrint("Data when first initialised: " + box.read("uid").toString());
    if (box.hasData("uid")) {
      return true;
    } else {
      return false;
    }
  }
}
