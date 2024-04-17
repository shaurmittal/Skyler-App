import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase_constants.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;
  var isDrawerClosed = true.obs;

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

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

  late TabController tabController;

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

  logout() async {
    isLoading(true);
    await firebaseAuth.signOut();
    Get.offAllNamed(Routes.SIGNUP);
    isLoading(false);
  }
}
