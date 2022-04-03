import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/authentication_widget.dart';
import '../../controllers/auth_controller.dart';
import 'sign_up_view.dart';

class EmailPageView {
  PageView getEmailPageView() {
    SignIn signIn = Get.put(const SignIn());
    SignUp signUp = Get.put(const SignUp());
    AuthController controller = Get.put(AuthController());
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.authenticationPageController,
      children: [
        signIn,
        signUp,
      ],
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationWidget authenticationWidget = Get.put(AuthenticationWidget());
    return authenticationWidget.getAuthenticationWidget(true);
  }
}
