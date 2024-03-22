import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:main_sociavism/components/my_button.dart';
import 'package:main_sociavism/components/my_textfield.dart';
import 'package:main_sociavism/utils.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? typeController;
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final List<String> items = ["NGO", "Volunteer"];

  // User? currentUser = FirebaseAuth.instance.currentUser;

  void signUserUp() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // try sign inx
    try {
      // check if password = confirmed password

      if (passwordConfirmed()) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) {
            addUserDetails(
              username: usernameController.text.trim(),
              email: emailController.text.trim(),
              role: typeController!,
              bio: bioController.text.trim(),
              file: _image!,
            );
          });
        } catch (e) {
          print(e);
        }
      } else {
        // show error message, passwords dont match
        showErrorMessage("Passwords don't match");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print(e.code);
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Text(
              message,
              style: TextStyle(color: Colors.purple),
            )),
          );
        });
  }

  @override
  void dispose() {
    bioController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  // image functions

  Uint8List? _image;

  Future addUserDetails(
      {required String username,
      required String email,
      required String role,
      required String bio,
      required Uint8List file}) async {
    String resp = "Some error occured";
    var currentUser = await FirebaseAuth.instance.currentUser;
    print(currentUser!.uid);
    try {
      if (username.isNotEmpty || email.isNotEmpty || bio.isNotEmpty) {
        String imageUrl = await uploadImageToStorage(currentUser.uid, file);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .set({
          'username': username,
          'email': email,
          'role': role,
          'imageLink': imageUrl,
          'bio': bio
        });
        resp = "Success";
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }

  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    Reference ref = _storage.ref().child(childname);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Picture
          Stack(children: [
            _image != null
                ? CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  )
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://imgs.search.brave.com/JSJcYbrha0qTJvlv5Tcd3xfTL6CgmvaqZDo5-e_F66Q/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9oLW8t/bS1lLm9yZy93cC1j/b250ZW50L3VwbG9h/ZHMvMjAyMi8wNC9C/bGFuay1Qcm9maWxl/LVBpY3R1cmUtMi5q/cGc'),
                  ),
            Positioned(
              child: IconButton(
                icon: LineIcon.edit(
                  size: 35,
                ),
                onPressed: selectImage,
              ),
              bottom: -10,
              left: 80,
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          // username text
          MyTextField(
            controller: usernameController,
            hintText: 'Username',
            obscureText: false,
          ),

          const SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox(
            height: 10,
          ),

          MyTextField(
            controller: bioController,
            hintText: 'Description',
            obscureText: false,
          ),
          const SizedBox(
            height: 10,
          ),

          // password text
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 10),

          MyTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
            child: DropdownButtonHideUnderline(
                child: DropdownButton2(
              alignment: Alignment.center,
              isDense: true,
              isExpanded: true,
              hint: Text("Are you an NGO or a Volunteer?"),
              items: items
                  .map((String item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              value: typeController,
              onChanged: (String? value) {
                setState(() {
                  typeController = value!;
                });
              },
            )),
          ),

          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),

          const SizedBox(height: 10),
          // sign in button
          MyButton(
            text: "Sign Up",
            onTap: signUserUp,
          ),

          const SizedBox(height: 15),

          // not a member? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  "Login now",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
