import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_sociavism/components/back_button.dart';
import 'package:main_sociavism/components/follow_button.dart';
import 'package:main_sociavism/utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var datalength = data.exists;
              if (datalength == false) {
                return const Center(
                  child: Text("NO DATA FOUND"),
                );
              } else {
                Map<String, dynamic>? user = snapshot.data!.data();

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 0),
                            child: Row(
                              children: [
                                MyBackButton(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Stack(children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundImage:
                                          NetworkImage(user!['imageLink']),
                                    ),
                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            children: [
                              Text(
                                user!['username'],
                                style: const TextStyle(
                                    fontFamily: 'LTSoul', fontSize: 30),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                user['role'],
                                style: TextStyle(
                                    fontFamily: 'LTSoul', fontSize: 25),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[500],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "45",
                                        style: TextStyle(
                                            fontSize: 30, fontFamily: 'LTSoul'),
                                      ),
                                      Text(
                                        'Followers',
                                        style: TextStyle(
                                            fontSize: 20, fontFamily: 'LTSoul'),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                            fontSize: 30, fontFamily: 'LTSoul'),
                                      ),
                                      Text(
                                        'Events Organised',
                                        style: TextStyle(
                                            fontSize: 20, fontFamily: 'LTSoul'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FollowButton(text: "Follow", onTap: () {}),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          const Text(
                            "Posts:",
                            style:
                                TextStyle(fontSize: 23, fontFamily: 'LTSoul'),
                          )
                        ]),
                  ),
                );
              }
            }
          }),
    );
  }
}
