import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/firebase_constants.dart';
import '../../../constants/hive_constants.dart';
import '../../../models/ngo_model.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';
import 'package:intl/intl.dart';

import '../pages/volunteers_page.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController instance = Get.find();

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;
  var isDrawerClosed = true.obs;
  var isActive = true.obs;
  var currentUserIndex = 0.obs;
  var currentPostId = ''.obs;

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> postFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> userUpdateFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoUpdateFormKey = GlobalKey<FormState>();

  TextEditingController captionController = TextEditingController();
  TextEditingController participantController = TextEditingController();

  late TabController tabController;

  var postImgUrl = [].obs;
  var userList = List<UserModel>.empty(growable: true).obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  TextEditingController aboutNgoController = TextEditingController();

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
    Hive.close();
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
    setLoggedIn(false);
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
            'creatorId': post.creatorId,
            'caption': post.caption,
            'images': post.images,
            'volunteerLimit': post.volunteerLimit,
            'volunteers': post.volunteers,
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

  getUserDetails({required String userId}) async {
    try {
      var data = await firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromJson(data.data()!);
    } catch (e) {
      print(e);
      loadingFalse();
    }
  }

  getUserId() async {
    final User? currentUser = await firebaseAuth.currentUser;
    return currentUser!.uid;
  }

  getNgoDetails() async {
    try {
      final User? currentUser = await firebaseAuth.currentUser;
      print(currentUser!.uid);
      var data =
          await firebaseFirestore.collection('ngos').doc(currentUser.uid).get();
      print(data.data());
      return NgoModel.fromJson(data.data()!);
    } catch (e) {
      print(e);
    }
  }

  setUser() async {
    loadingTrue();
    UserModel user = await getUserDetails(userId: await getUserId());
    imageUrl(user.profilePhoto);
    emailController.text = user.email;
    nameController.text = user.name;
    ageController.text = user.age;
    locationController.text = user.location;
    phoneController.text = user.phoneNo;
    socialController.text = user.socialLink;
    loadingFalse();
  }

  setNgo() async {
    loadingTrue();
    NgoModel ngo = await getNgoDetails();
    imageUrl(ngo.profilePhoto);
    emailController.text = ngo.email;
    nameController.text = ngo.name;
    locationController.text = ngo.location;
    phoneController.text = ngo.phoneNo;
    socialController.text = ngo.socialLink;
    aboutNgoController.text = ngo.about;
    loadingFalse();
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
            creatorId: doc['creatorId'],
            caption: doc['caption'],
            images: doc['images'],
            volunteers: doc['volunteers'] ?? [],
            volunteerLimit: doc['volunteerLimit'],
            isEvent: doc['isEvent'],
            createdAt: doc['createdAt'],
            updatedAt: doc['updatedAt'],
          );
        }).toList());
  }

  Stream<List<PostModel>> getNgoPosts() {
    try {
      Stream<QuerySnapshot> stream = firebaseFirestore
          .collection('posts')
          .where('creatorId', isEqualTo: getUserId())
          .where('isEvent', isEqualTo: false)
          .snapshots();

      return stream.map((var qShot) => qShot.docs.map((doc) {
            return PostModel(
              id: doc['id'],
              creator: NgoModel.fromJson(jsonDecode(doc['creator'])),
              creatorId: doc['creatorId'],
              caption: doc['caption'],
              images: doc['images'],
              volunteers: doc['volunteers'] ?? [],
              volunteerLimit: doc['volunteerLimit'],
              isEvent: doc['isEvent'],
              createdAt: doc['createdAt'],
              updatedAt: doc['updatedAt'],
            );
          }).toList());
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Stream<List<PostModel>> getNgoEvent() {
    Stream<QuerySnapshot> stream = firebaseFirestore
        .collection('posts')
        .where('creatorId', isEqualTo: getUserId())
        .where('isEvent', isEqualTo: true)
        .snapshots();
    return stream.map((var qShot) => qShot.docs.map((doc) {
          return PostModel(
            id: doc['id'],
            creator: NgoModel.fromJson(jsonDecode(doc['creator'])),
            creatorId: doc['creatorId'],
            caption: doc['caption'],
            images: doc['images'],
            volunteers: doc['volunteers'] ?? [],
            volunteerLimit: doc['volunteerLimit'],
            isEvent: doc['isEvent'],
            createdAt: doc['createdAt'],
            updatedAt: doc['updatedAt'],
          );
        }).toList());
  }

  handleVolunteer(PostModel post) async {
    if (post.creator.id == firebaseAuth.currentUser!.uid) {
      loadingTrue();
      currentPostId(post.id);
      Get.to(() => VolunteersPage());
      userList.clear();
      for (var uid in post.volunteers) {
        userList.add(await getUserDetails(userId: uid));
      }
      loadingFalse();
    } else if (getUserType() == UserType.USER.name) {
      final User? currentUser = firebaseAuth.currentUser;
      if (post.volunteers.isEmpty) {
        var volunteerList = [];
        volunteerList.add(currentUser!.uid);
        await firebaseFirestore.collection('posts').doc(post.id).update({
          'volunteers': volunteerList,
        }).then((value) {
          showAppSnackBar(
            message: 'Registered as a volunteer !',
            toastType: ToastType.success,
          );
        });
      } else if (post.volunteers.length == post.volunteerLimit) {
        showAppSnackBar(
          message: 'Volunteer limit reached !',
          toastType: ToastType.error,
        );
      } else if (post.volunteers.isNotEmpty &&
          !post.volunteers.contains(currentUser!.uid)) {
        var volunteerList = post.volunteers;
        volunteerList.add(currentUser.uid);
        await firebaseFirestore.collection('posts').doc(post.id).update({
          'volunteers': volunteerList,
        }).then((value) {
          showAppSnackBar(
            message: 'Registered as a volunteer !',
            toastType: ToastType.success,
          );
        });
      } else {
        showAppSnackBar(
          message: "You've already applied !",
          toastType: ToastType.error,
        );
      }
    } else {
      showAppSnackBar(
        message: "Ngo's are not allowed to volunteer!",
        toastType: ToastType.error,
      );
      showAppSnackBar(
        message: "Sign up as a volunteer !",
        toastType: ToastType.info,
      );
    }
  }

  removeVolunteer({required String postId}) async {
    loadingTrue();
    try {
      await firebaseFirestore.collection('posts').doc(postId).update({
        'volunteers': userList.map((element) => element.id).toList(),
      }).then((value) {
        loadingFalse();
        showAppSnackBar(
          message: 'Volunteer removed !',
          toastType: ToastType.success,
        );
      });
    } catch (e) {
      print(e);
      loadingFalse();
      showAppSnackBar(
        message: "Something went wrong !",
        toastType: ToastType.error,
      );
    }
  }

  updateUser({required UserModel user}) async {
    if (userUpdateFormKey.currentState!.validate()) {
      loadingTrue();
      try {
        await firebaseFirestore.collection('users').doc(user.id).set({
          'id': user.id,
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
          getUserDetails(userId: await getUserId());
          Get.back();
          showAppSnackBar(
            message: 'Details updated successfully',
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

  updateNGO({required NgoModel user}) async {
    if (ngoUpdateFormKey.currentState!.validate()) {
      loadingTrue();
      try {
        await firebaseFirestore.collection('ngos').doc(user.id).set({
          'id': user.id,
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
          getNgoDetails();
          Get.back();
          showAppSnackBar(
            message: 'Details updated successfully',
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
