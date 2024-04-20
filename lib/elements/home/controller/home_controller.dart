import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;
  var isDrawerClosed = true.obs;
  var isActive = true.obs;

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> postFormKey = GlobalKey<FormState>();

  TextEditingController captionController = TextEditingController();
  TextEditingController participantController = TextEditingController();

  late TabController tabController;

  var postImgUrl = [].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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

  switchIsActive(var value) {
    isActive(value);
  }

  logout() async {
    isLoading(true);
    await firebaseAuth.signOut();
    Get.offAllNamed(Routes.SIGNUP);
    isLoading(false);
  }

  createPost() {
    if (postFormKey.currentState!.validate()) {
      print(postImgUrl.length);
      if (postImgUrl.length > 5) {
        showAppSnackBar(
          message: 'Only 5 photos are allowed',
          toastType: ToastType.error,
        );
      } else {
        Get.back();
        showAppSnackBar(
          message: 'Post Uploaded',
          toastType: ToastType.success,
        );
      }
    }
  }
}
