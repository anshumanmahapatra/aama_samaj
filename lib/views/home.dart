import 'package:aama_samaj_temp_frontend/services/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth/phone_auth.dart';
import '../services/auth/google_sign_in_auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhoneAuth phoneAuth = Get.put(PhoneAuth());
    GoogleSignInAuth googleSignInAuth = Get.put(GoogleSignInAuth());
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Center(
              child: ElevatedButton(
                  child: const Text("Sign Out"),
                  onPressed: () {
                    if (box.read("provider").toString() == "google.com") {
                      googleSignInAuth.signOut();
                    } else {
                    phoneAuth.signOut();
                    }
                  })),
        ));
  }
}
