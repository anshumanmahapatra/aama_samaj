import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../services/storage/storage.dart';
import '../../views/home.dart';
import '../../views/pseudo_home.dart';
import '../../widgets/alert_dialog.dart';

class PhoneAuth {
  AuthController authController = Get.put(AuthController());
  Home home = Get.put(const Home());
  PseudoHome pseudoHome = Get.put(const PseudoHome());
  ShowAlertDialog alertDialog = Get.put(ShowAlertDialog());
  FirebaseAuth auth = FirebaseAuth.instance;

  Future phoneAuth(String phoneNumber) async {
    authController.showLoading(true);

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          authController.showLoading(false);
        },
        verificationFailed: (verificationFailed) async {
          authController.showLoading(false);
          Get.dialog(AlertDialog(
            title: const Text("Error"),
            content: Text(verificationFailed.message.toString()),
            actions: [
              ElevatedButton(
                child: const Text("Ok"),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ));
        },
        codeSent: (verificationId, resendingToken) async {
          authController.showLoading(false);
          authController.isOTPSent(true);
          authController.assignVerificationId(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future authenticatePhoneUser(String otp) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: authController.verificationId.value, smsCode: otp);

    authController.showLoading(true);

    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthCredential);

      authController.showLoading(false);

      if (authCredential.user != null) {
        debugPrint("Before writing data: " + box.read("uid").toString());
        box.write("uid", authCredential.user!.uid.toString());
        box.write("provider", authCredential.user!.providerData[0].providerId);
        debugPrint("After writing data: " + box.read("uid").toString());
        debugPrint("Provider" + box.read('provider').toString());
        Get.off(() => home);
        authController.isOTPSent(false);
      }
    } on FirebaseAuthException catch (e) {
      authController.showLoading(false);

      Get.dialog(alertDialog.showAlertDialog(e.message.toString()));
    }
  }

  Future signOut() async {
    User? user = auth.currentUser;
    debugPrint("Service Provider: " + user!.providerData[0].providerId);
    await auth.signOut();
    debugPrint("Before signing out: " + box.read("uid").toString());
    box.remove("uid");
    box.remove("provider");
    debugPrint("After signing out: " + box.read("uid").toString());
    Get.off(() => pseudoHome);
  }
}
