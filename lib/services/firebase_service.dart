import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/firebase_constants.dart';
import '../utils/common_widgets/snack_bar.dart';

Future getImageGallery(dynamic controller) async {
  showAppSnackBar(message: 'File not selected', toastType: ToastType.success);

  var status = Permission.storage.status;
  if (await status.isGranted) {
    print('gallery permisson granted');
    controller.isImageLoading(true);
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (image != null) {
      await _uploadImageStorage(image, controller);
    } else {
      showAppSnackBar(message: 'File not selected', toastType: ToastType.error);
      controller.isImageLoading(false);
    }
    // image!.clear();
  } else if (await status.isDenied) {
    if (await Permission.storage.request().isGranted) {
      print('gallery permisson granted');

      controller.isImageLoading(true);
      final ImagePicker _picker = ImagePicker();
      var image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        await _uploadImageStorage(image, controller);
      } else {
        showAppSnackBar(
            message: 'File not selected', toastType: ToastType.error);
        controller.isImageLoading(false);
      }
      // image!.clear();
    }
  }
}

Future<void> _uploadImageStorage(XFile image, dynamic controller) async {
  try {
    controller.isImageLoading(true);
    int randomNumber = Random().nextInt(100000);
    String imageLocation = 'sociavism/image_$randomNumber';

    Reference ref = firebaseStorage.ref().child(imageLocation);
    UploadTask uploadTask = ref.putFile(File(image.path));
    await uploadTask.then((res) async {
      var downloadUrl = await res.ref.getDownloadURL();
      controller.imageUrlforFirestore(downloadUrl);
      print(downloadUrl);
    });
  } catch (e) {
    print(e);
    // await crashlytics.log("failed to upload image $e");
  } finally {
    controller.isImageLoading(false);
  }
}

Future getImageListGallery(dynamic controller) async {
  controller.isImageLoading(true);
  final ImagePicker _picker = ImagePicker();
  List<XFile>? image = await _picker.pickMultiImage(
    imageQuality: 50,
  );
  if (image != null) {
    await _uploadImageListStorage(image, controller);
  } else {
    showAppSnackBar(message: 'File not selected', toastType: ToastType.error);
    controller.isImageLoading(false);
  }
  image.clear();
  controller.isImageLoading(false);
}

Future _uploadImageListStorage(List<XFile> image, dynamic controller) async {
  for (int i = 0; i < image.length; i++) {
    int randomNumber = Random().nextInt(100000);
    try {
      Reference reference = firebaseStorage
          .ref()
          .child('sociavism')
          .child('image__$randomNumber');
      await reference.putFile(File(image[i].path));
      controller.imageUrlforFirestore.add(await reference.getDownloadURL());
    } catch (e) {
      print(e);
      // await crashlytics.log("failed to upload image $e");
    }
  }
}
