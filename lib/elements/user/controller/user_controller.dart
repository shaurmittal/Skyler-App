import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;

  GlobalKey<FormState> userDetailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoDetailFormKey = GlobalKey<FormState>();

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

  addUserDetails({
    required String email,
    required String profilePic,
    required String name,
    required String age,
    required String location,
    required String phoneNo,
    required String socialLink,
  }) async {
    if (userDetailFormKey.currentState!.validate()) {
      loadingTrue();
      var currentUser = await firebaseAuth.currentUser;
      print(currentUser!.uid);
      try {
        await firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'uid': currentUser.uid,
          'email': email,
          'profilePic': profilePic,
          'name': name,
          'age': age,
          'location': location,
          'phoneNo': phoneNo,
          'socialLink': socialLink,
          'created': DateTime.now(),
        }).then((value) async {
          Get.toNamed(Routes.HOME);
          showAppSnackBar(
            message: 'Welcome To Sociavism',
            toastType: ToastType.theme,
          );
        });
      } catch (e) {
        print(e);
      }
      loadingFalse();
    }
  }

  logout() async {
    isLoading(true);
    await firebaseAuth.signOut();
    isLoading(false);
  }
}
