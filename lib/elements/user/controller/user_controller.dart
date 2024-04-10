import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> userDetailFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void loadingTrue() {
    isLoading(true);
  }

  void loadingFalse() {
    isLoading(false);
  }

  clearControllers() {
    isLoading = false.obs;
    isVisiblePass = true.obs;
  }

  home() {
    // if (signupFormKey.currentState!.validate()) {}
  }
}
