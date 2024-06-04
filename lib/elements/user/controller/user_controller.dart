import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/firebase_constants.dart';
import '../../../constants/hive_constants.dart';
import '../../../models/ngo_model.dart';
import '../../../models/user_model.dart';
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

  addUserDetails({required UserModel user}) async {
    if (userDetailFormKey.currentState!.validate()) {
      loadingTrue();
      var currentUser = await firebaseAuth.currentUser;
      print(currentUser!.uid);
      try {
        await firebaseFirestore.collection('users').doc(currentUser.uid).set({
          'id': currentUser.uid,
          'email': user.email,
          'profilePhoto': user.profilePhoto,
          'name': user.name,
          'age': user.age,
          'location': user.location,
          'phoneNo': user.phoneNo,
          'socialLink': user.socialLink,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt,
        }).then((value) async {
          setLoggedIn(true);
          setUserType(UserType.USER.name);
          Get.offAllNamed(Routes.HOME);
          showAppSnackBar(
            message: 'Welcome To Sociavism!',
            toastType: ToastType.theme,
          );
        });
      } catch (e) {
        print(e);
        showAppSnackBar(
          message: 'Something went wrong',
          toastType: ToastType.error,
        );
      }
      loadingFalse();
    }
  }

  addNGODetails({required NgoModel user}) async {
    if (ngoDetailFormKey.currentState!.validate()) {
      loadingTrue();
      final User? currentUser = await firebaseAuth.currentUser;
      print(currentUser!.uid);
      try {
        await firebaseFirestore.collection('ngos').doc(currentUser.uid).set({
          'id': currentUser.uid,
          'email': user.email,
          'profilePhoto': user.profilePhoto,
          'name': user.name,
          'about': user.about,
          'location': user.location,
          'phoneNo': user.phoneNo,
          'socialLink': user.socialLink,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt,
        }).then((value) async {
          setLoggedIn(true);
          setUserType(UserType.NGO.name);
          Get.offAllNamed(Routes.HOME);
          showAppSnackBar(
            message: 'Welcome To Sociavism!',
            toastType: ToastType.theme,
          );
        });
      } catch (e) {
        print(e);
        showAppSnackBar(
          message: 'Something went wrong.',
          toastType: ToastType.error,
        );
      }
      loadingFalse();
    }
  }

  logout() async {
    isLoading(true);
    setLoggedIn(false);
    await firebaseAuth.signOut();
    isLoading(false);
  }
}
