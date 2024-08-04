import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmyngo/elements/home/pages/ngo_volunteers_page.dart';
import 'package:findmyngo/elements/home/widgets/credit_bottom_sht.dart';
import 'package:findmyngo/models/mission_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/firebase_constants.dart';
import '../../../constants/hive_constants.dart';
import '../../../models/ngo_model.dart';
import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_widgets/snack_bar.dart';
import '../pages/volunteers_page.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeController instance = Get.find();

  final User? currentUser = firebaseAuth.currentUser.obs.value;

  var isLoading = false.obs;
  var isImageLoading = false.obs;
  var isVisiblePass = true.obs;
  var imageUrl = ''.obs;
  var isDrawerClosed = true.obs;
  var isActive = true.obs;
  var currentUserIndex = 0.obs;
  var currentPostId = ''.obs;
  var currentMissionId = ''.obs;
  var isCurrentUserNgo = false.obs;

  var ngoGem = 0;

  bool isAdminId = false;

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> leaderboardKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> postFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> userUpdateFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> ngoUpdateFormKey = GlobalKey<FormState>();

  TextEditingController captionController = TextEditingController();
  TextEditingController participantController = TextEditingController();

  late TabController tabController;

  var postImgUrl = [].obs;
  var userList = List<UserModel>.empty(growable: true).obs;
  var missionUserList = List<NgoModel>.empty(growable: true).obs;

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
    getAdminAccess();
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

  void showLearderBoardBottomModelSheet() {
    Get.bottomSheet(
      CreditBottomSheet(
        onDone: () {
          Get.back();
        },
      ),
    );
  }

  void deleteUserWithConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text(
            'Do you really want to delete your account? This will delete all posts and your data from our servers, and you cannot recover it.'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () async {
              Get.back(); // Close the dialog
              await deleteUser();
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteUser() async {
    isLoading(true);
    setLoggedIn(false);

    try {
      String userId = await getUserId();

      if (getUserType() == UserType.USER.name) {
        await firebaseFirestore.collection('users').doc(userId).delete();
      } else {
        deleteNgoPosts(userId);
        await firebaseFirestore.collection('ngos').doc(userId).delete();
      }

      await firebaseAuth.currentUser?.delete();
      await firebaseAuth.signOut();
      Get.offAllNamed(Routes.SIGNUP);
    } catch (e) {
      showAppSnackBar(
        message: 'Failed to delete user. Please try again.',
        toastType: ToastType.error,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNgoPosts(String userId) async {
    try {
      QuerySnapshot snapshot = await firebaseFirestore
          .collection('posts')
          .where('creatorId', isEqualTo: userId)
          .get();

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await firebaseFirestore.collection('posts').doc(doc.id).delete();
      }
    } catch (e) {
      print(e);
      showAppSnackBar(
        message: 'Failed to delete posts',
        toastType: ToastType.error,
      );
    }
  }

  createPost({required PostModel post}) async {
    if (postFormKey.currentState!.validate()) {
      print(postImgUrl.length);
      if (postImgUrl.length > 5) {
        showAppSnackBar(
          message: 'Only 5 photos are allowed.',
          toastType: ToastType.error,
        );
      } else {
        loadingTrue();
        var uuid = const Uuid();
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
              message: 'Post Uploaded.',
              toastType: ToastType.success,
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

  Future<void> addPointsAndGemsInNgoProfile(MissionModel model) async {
    try {
      final User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }

      // Fetch the mission details
      final missionDoc =
          await firebaseFirestore.collection('missions').doc(model.id).get();
      if (!missionDoc.exists) {
        throw Exception("Mission not found");
      }

      final missionData = missionDoc.data()!;
      final ngoVolunteersId =
          List<String>.from(missionData['ngoVolunteersId'] ?? []);

      // Check if the NGO has already collected points for this mission
      if (ngoVolunteersId.contains(currentUser.uid)) {
        showAppSnackBar(
          message: 'You have already collected points for this mission.',
          toastType: ToastType.info,
        );
        return;
      }

      // Update the mission to mark the NGO as having received points
      await firebaseFirestore.collection('missions').doc(model.id).update({
        'ngoVolunteersId': FieldValue.arrayUnion([currentUser.uid]),
      });

      // Fetch the current NGO details
      final ngoDoc =
          await firebaseFirestore.collection('ngos').doc(currentUser.uid).get();
      if (!ngoDoc.exists) {
        throw Exception("NGO details not found");
      }

      final ngoData = ngoDoc.data()!;
      int newPoints = ngoData['points'] + 1;
      int newGems = ngoData['gems'];
      if (newPoints % 10 == 0) {
        newGems += 1;
      }

      // Update the NGO profile with new points and gems
      await firebaseFirestore.collection('ngos').doc(currentUser.uid).update({
        'points': newPoints,
        'gems': newGems,
      });

      // Show success message
      showAppSnackBar(
        message: '1 Point added and gems updated in your profile.',
        toastType: ToastType.success,
      );
    } catch (e) {
      print(e);
      showAppSnackBar(
        message: 'Failed to update points and gems. Please try again.',
        toastType: ToastType.error,
      );
    }
  }

  getUserAccountStats() async {
    String userId = await getUserId();
    UserModel user = await getUserDetails(userId: userId);
    return user;
  }

  getUserId() async {
    final User? currentUser = await firebaseAuth.currentUser;
    print(currentUser!.uid);
    return currentUser.uid;
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

  getNgoUserId({required String ngoUserId}) async {
    try {
      var data =
          await firebaseFirestore.collection('ngos').doc(ngoUserId).get();
      return NgoModel.fromJson(data.data()!);
    } catch (e) {
      print(e);
      loadingFalse();
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

  Stream<List<MissionModel>> getAllMissions() {
    Stream<QuerySnapshot> stream =
        firebaseFirestore.collection('missions').snapshots();
    return stream.map((var qShot) => qShot.docs.map((doc) {
          return MissionModel(
            creator: NgoModel.fromJson(jsonDecode(doc['creator'])),
            id: doc['id'],
            ngoVolunteersId: doc['ngoVolunteersId'] ?? [],
            creatorId: doc['creatorId'],
            caption: doc['caption'],
            images: doc['images'],
            ngoVolunteers: doc['ngoVolunteers'] ?? [],
            ngoLimit: doc['ngoLimit'],
            createdAt: doc['createdAt'],
            updatedAt: doc['updatedAt'],
          );
        }).toList());
  }

  Stream<List<PostModel>> getNgoPosts() {
    try {
      final User? currentUser = firebaseAuth.currentUser;
      print(currentUser!.uid);
      Stream<QuerySnapshot> stream = firebaseFirestore
          .collection('posts')
          .where('creatorId', isEqualTo: currentUser.uid)
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
    final User? currentUser = firebaseAuth.currentUser;
    print(currentUser!.uid);
    Stream<QuerySnapshot> stream = firebaseFirestore
        .collection('posts')
        .where('creatorId', isEqualTo: currentUser.uid)
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

  handleNgoVolunteer(MissionModel mission) async {
    if (getUserType() == UserType.NGO.name) {
      loadingTrue();
      final User? currentUser = firebaseAuth.currentUser;
      final ngoDetails = await getNgoDetails();

      // Check if the current NGO is the creator of the mission
      if (mission.creatorId == currentUser!.uid) {
        // Display the list of volunteers
        currentMissionId(mission.id);
        Get.to(() => NgoVolunteersPage());
        missionUserList.clear();
        for (var uid in mission.ngoVolunteers) {
          missionUserList.add(await getNgoUserId(ngoUserId: uid));
        }
        loadingFalse();
      } else {
        if (mission.ngoVolunteers.isEmpty) {
          // Register the NGO as the first volunteer
          var ngoVolunteersList = [];
          ngoVolunteersList.add(currentUser.uid);
          await firebaseFirestore
              .collection('missions')
              .doc(mission.id)
              .update({
            'ngoVolunteers': ngoVolunteersList,
          }).then((value) {
            showAppSnackBar(
              message: 'Registered as a Volunteer.',
              toastType: ToastType.success,
            );
          });
        } else if (mission.ngoVolunteers.length == mission.ngoLimit) {
          showAppSnackBar(
            message: 'Volunteer limit reached.',
            toastType: ToastType.error,
          );
        } else if (mission.ngoVolunteers.isNotEmpty &&
            !mission.ngoVolunteers.contains(currentUser.uid)) {
          var ngoVolunteersList = mission.ngoVolunteers;
          ngoVolunteersList.add(currentUser.uid);
          await firebaseFirestore
              .collection('missions')
              .doc(mission.id)
              .update({
            'ngoVolunteers': ngoVolunteersList,
          }).then((value) {
            showAppSnackBar(
              message: 'Registered as a Volunteer.',
              toastType: ToastType.success,
            );
          });
        } else {
          showAppSnackBar(
            message: "You've already applied.",
            toastType: ToastType.error,
          );
        }
      }
    } else {
      showAppSnackBar(
        message: "Only NGOs can volunteer.",
        toastType: ToastType.error,
      );
      showAppSnackBar(
        message: "Sign up as an NGO to participate!",
        toastType: ToastType.info,
      );
    }
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
            message: 'Registered as a Volunteer.',
            toastType: ToastType.success,
          );
        });
      } else if (post.volunteers.length == post.volunteerLimit) {
        showAppSnackBar(
          message: 'Volunteer limit reached.',
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
            message: 'Registered as a Volunteer.',
            toastType: ToastType.success,
          );
        });
      } else {
        showAppSnackBar(
          message: "You've already applied.",
          toastType: ToastType.error,
        );
      }
    } else {
      showAppSnackBar(
        message: "NGOs are not allowed to Volunteer.",
        toastType: ToastType.error,
      );
      showAppSnackBar(
        message: "Sign up as a Volunteer!",
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
          message: 'Volunteer removed!',
          toastType: ToastType.success,
        );
      });
    } catch (e) {
      print(e);
      loadingFalse();
      showAppSnackBar(
        message: "Something went wrong.",
        toastType: ToastType.error,
      );
    }
  }

  getAdminAccess() async {
    var adminId =
        await firebaseFirestore.collection('admin').doc('access_id').get();
    if (adminId.data() != null) {
      if (adminId.data()!['id'] == await getUserId()) {
        isAdminId = true;
      } else {
        isAdminId = false;
      }
    }
  }

  checkIfCurrentUserIsNgo() {
    if (getUserType() == UserType.NGO.name) {
      return true;
    } else {
      return false;
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
            message: 'Details updated successfully!',
            toastType: ToastType.success,
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

  updateNGO({
    required NgoModel user,
  }) async {
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
          'gems': user.gems,
        }).then((value) async {
          getNgoDetails();
          Get.back();
          showAppSnackBar(
            message: 'Details updated successfully!',
            toastType: ToastType.success,
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

  showSnackBar({required String message, required ToastType toastType}) {
    showAppSnackBar(
      message: message,
      toastType: toastType,
    );
  }

  Stream<List<NgoModel>> getTop10NgoWithPoints() {
    return firebaseFirestore
        .collection('ngos')
        .orderBy('points', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return NgoModel.fromJson(data);
      }).toList();
    });
  }

  createMission({required MissionModel mission}) async {
    if (postFormKey.currentState!.validate()) {
      print(postImgUrl.length);
      if (postImgUrl.length > 5) {
        showAppSnackBar(
          message: 'Only 5 photos are allowed.',
          toastType: ToastType.error,
        );
      } else {
        loadingTrue();
        var uuid = const Uuid();
        var mID = uuid.v4();

        try {
          print(mission.creator);
          await firebaseFirestore.collection('missions').doc(mID).set({
            'id': mID,
            'creator': jsonEncode(mission.creator.toJson()),
            'creatorId': mission.creatorId,
            'caption': mission.caption,
            'images': mission.images,
            'ngoLimit': mission.ngoLimit,
            'ngoVolunteers': mission.ngoVolunteers,
            'createdAt': mission.createdAt,
            'updatedAt': mission.updatedAt,
          }).then((value) async {
            Get.back();
            showAppSnackBar(
              message: 'Mission Uploaded.',
              toastType: ToastType.success,
            );
          });

          postImgUrl.clear();
          participantController.clear();
          captionController.clear();
          Get.back();
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
  }
}
