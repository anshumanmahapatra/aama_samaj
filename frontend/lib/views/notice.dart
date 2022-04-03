import 'package:flutter/material.dart';

class Notice extends StatelessWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: RichText(
            text: const TextSpan(
                text: "Notice",
                style: TextStyle(
                    color: Color(0xFF071E22),
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Color(0xFF071E22)),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
        ),
        body: Container(
            width: double.infinity,
            child: Image.asset(
              "assets/images/notice.png",
            )));
  }
}
