import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowAlertDialog {
  AlertDialog showAlertDialog(String message) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(message),
      actions: [
        ElevatedButton(
          child: const Text("Ok"),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }
}