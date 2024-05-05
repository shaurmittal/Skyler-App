import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/firebase_constants.dart';
import '../../../constants/hive_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';

class AuthController extends GetxController {
  // OnboardController();

  static AuthController instance = Get.find();

  var isLoading = false.obs;
  var isVisiblePass = true.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoLoginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoSignupFormKey = GlobalKey<FormState>();

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

  signUp({required bool isNGO}) async {
    try {
      if (isNGO) {
        if (ngoSignupFormKey.currentState!.validate()) {
          loadingTrue();
          await firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) {
            Get.toNamed(
              Routes.NGOUSERDETAILS,
              arguments: emailController.text,
            );
          });
        }
      } else {
        if (signupFormKey.currentState!.validate()) {
          loadingTrue();
          await firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) {
            Get.toNamed(
              Routes.USERDETAILS,
              arguments: emailController.text,
            );
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showAppSnackBar(
        message: e.message!,
        toastType: ToastType.error,
      );
    }
    loadingFalse();
  }

  login({required bool isNGO}) async {
    try {
      if (isNGO) {
        if (ngoSignupFormKey.currentState!.validate()) {
          loadingTrue();
          await firebaseAuth
              .signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) async {
            setLoggedIn(true);
            Get.offAllNamed(
              Routes.HOME,
              arguments: emailController.text,
            );
          });
        }
      } else {
        if (signupFormKey.currentState!.validate()) {
          loadingTrue();
          await firebaseAuth
              .signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) async {
            setLoggedIn(true);
            Get.offAllNamed(
              Routes.HOME,
              arguments: emailController.text,
            );
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      showAppSnackBar(
        message: e.message!,
        toastType: ToastType.error,
      );
    }
    loadingFalse();
  }
}
