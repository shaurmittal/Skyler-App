import 'dart:convert';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/firebase_constants.dart';
import '../../../models/ngo_model.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';
import 'package:intl/intl.dart';

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

  setDate(String date) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(DateTime.parse(date));
  }

  logout() async {
    isLoading(true);
    await firebaseAuth.signOut();
    Get.offAllNamed(Routes.SIGNUP);
    isLoading(false);
  }

  createPost({required PostModel post}) async {
    if (postFormKey.currentState!.validate()) {
      print(postImgUrl.length);
      if (postImgUrl.length > 5) {
        showAppSnackBar(
          message: 'Only 5 photos are allowed',
          toastType: ToastType.error,
        );
      } else {
        loadingTrue();
        var uuid = Uuid();
        var postId = uuid.v4();
        try {
          print(post.creator);
          await firebaseFirestore.collection('posts').doc(postId).set({
            'id': postId,
            'creator': jsonEncode(post.creator.toJson()),
            'caption': post.caption,
            'images': post.images,
            'volunteers': post.volunteers,
            'volunteerLimit': post.volunteerLimit,
            'isEvent': post.isEvent,
            'createdAt': post.createdAt,
            'updatedAt': post.updatedAt,
          }).then((value) async {
            Get.back();
            showAppSnackBar(
              message: 'Post Uploaded',
              toastType: ToastType.success,
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
  }

  getUserDetails() async {
    try {
      final User? currentUser = firebaseAuth.currentUser;
      print(currentUser!.uid);
      var data = await firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      return UserModel.fromJson(data.data()!);
    } catch (e) {
      print(e);
    }
  }

  getNgoDetails() async {
    try {
      final User? currentUser = firebaseAuth.currentUser;
      print(currentUser!.uid);
      var data =
          await firebaseFirestore.collection('ngos').doc(currentUser.uid).get();
      print(data.data());
      return NgoModel.fromJson(data.data()!);
    } catch (e) {
      print(e);
    }
  }

  Stream<List<PostModel>> getAllPosts() {
    Stream<QuerySnapshot> stream =
        firebaseFirestore.collection('posts').snapshots();
    return stream.map((var qShot) => qShot.docs.map((doc) {
          print(NgoModel.fromJson(jsonDecode(doc['creator'])));
          print(doc['caption']);
          return PostModel(
            id: doc['id'],
            creator: NgoModel.fromJson(jsonDecode(doc['creator'])),
            caption: doc['caption'],
            images: doc['images'],
            volunteers: doc['volunteers'] ?? [''],
            volunteerLimit: doc['volunteerLimit'],
            isEvent: doc['isEvent'],
            createdAt: doc['createdAt'],
            updatedAt: doc['updatedAt'],
          );
        }).toList());
  }
}
