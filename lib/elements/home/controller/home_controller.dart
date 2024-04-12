import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;


  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController socialController = TextEditingController();

  TextEditingController ngoNameController = TextEditingController();
  TextEditingController aboutNgoController = TextEditingController();
  TextEditingController ngoLocationController = TextEditingController();
  TextEditingController ngoPhoneController = TextEditingController();
  TextEditingController ngoSocialController = TextEditingController();

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
