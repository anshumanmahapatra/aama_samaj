import 'package:aama_samaj_temp_frontend/services/storage/storage.dart';

import '../../controllers/auth_controller.dart';
import '../../views/home.dart';
import '../../widgets/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailAuth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthController authController = Get.put(AuthController());
  ShowAlertDialog alertDialog = Get.put(ShowAlertDialog());
  Home home = Get.put(const Home());

  Future logIntoAccount(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      debugPrint("Before writing data: " + box.read("uid").toString());
      box.write("uid", user!.uid.toString());
      box.write("provider", user.providerData[0].providerId);
      debugPrint("After writing data: " + box.read("uid").toString());
      debugPrint("Provider: " + box.read('provider').toString());
      Get.off(() => home);
    } catch (e) {
      authController.showLoading(false);
      Get.dialog(alertDialog.showAlertDialog(e.toString()));
    }
  }

  Future createAccount(String email, String name, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      debugPrint("Before writing data: " + box.read("uid").toString());
      box.write("uid", user!.uid.toString());
      box.write("provider", user.providerData[0].providerId);
      debugPrint("After writing data: " + box.read("uid").toString());
      debugPrint("Provider: " + box.read('provider').toString());
      Get.off(() => home);
    } catch (e) {
      authController.showLoading(false);
      Get.dialog(alertDialog.showAlertDialog(e.toString()));
    }
  }

  Future signOut() async {
    User? user = firebaseAuth.currentUser;
    debugPrint(user!.providerData[0].providerId);
    await firebaseAuth.signOut();
    return Future.value(true);
  }
}
