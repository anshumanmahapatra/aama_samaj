import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/loading.json"),
            const SizedBox(height: 40),
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
          ],
        ));
  }
}
