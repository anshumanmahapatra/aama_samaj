import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/auth_controller.dart';
import '../../services/storage/storage.dart';
import '../../views/pseudo_home.dart';
import '../../views/home.dart';
import '../../widgets/alert_dialog.dart';

class GoogleSignInAuth {
  AuthController authController = Get.put(AuthController());
  Home home = Get.put(const Home());
  PseudoHome pseudoHome = Get.put(const PseudoHome());
  ShowAlertDialog alertDialog = Get.put(ShowAlertDialog());

  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      authController.showGoogleLoading(true);

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;

      authController.showGoogleLoading(false);

      if (result.user != null) {
        debugPrint("Before writing data: " + box.read("uid").toString());
        box.write("uid", user!.uid.toString());
        box.write("provider", credential.providerId);
        debugPrint("After writing data: " + box.read("uid").toString());
        debugPrint("Provider: " + box.read('provider').toString());
        Get.off(() => home);
      }
    } on FirebaseAuthException catch (e) {
      Get.dialog(alertDialog.showAlertDialog(e.message.toString()));
    }
  }

  Future signOut() async {
    User? user = auth.currentUser;
    debugPrint("Service Provider: " + user!.providerData[0].providerId);
    if (user.providerData[0].providerId == 'google.com') {
      await googleSignIn.signOut();
    }
    await auth.signOut();
    debugPrint("Before signing out: " + box.read("uid").toString());
    box.remove("uid");
    box.remove('provider');
    debugPrint("After signing out: " + box.read("uid").toString());
    Get.off(() => pseudoHome);
  }
}
