import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/elements/user/pages/user_detail_page.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  // OnboardController();

  static AuthController instance = Get.find();

  var isLoading = false.obs;
  var isVisiblePass = true.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loadingTrue() {
    isLoading(true);
  }

  void loadingFalse() {
    isLoading(false);
  }

  setVisibiltyPass(var visible) {
    isVisiblePass(!visible);
  }

  clearControllers() {
    isLoading = false.obs;
    isVisiblePass = true.obs;
    emailController.clear();
    passwordController.clear();
  }

  signUp() {
    // if (signupFormKey.currentState!.validate()) {
    Get.toNamed(Routes.USERDETAILS);
    // }
  }
}
