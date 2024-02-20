import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final currentUser = FirebaseAuth.instance.currentUser;

class StoreData {
  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData(
      {required String name,
      required String bio,
      required String location,
      required Uint8List file}) async {
    String resp = "Some error occured";
    var currentUser = await FirebaseAuth.instance.currentUser;
    try {
      if (name.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadImageToStorage(currentUser!.uid, file);
        await _firestore.collection('users').doc(currentUser.uid).set({
          'username': name,
          'bio': bio,
          'location': location,
          'imageLink': imageUrl,
        });

        resp = 'Success';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
