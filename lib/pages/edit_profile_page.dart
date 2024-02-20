import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:main_sociavism/components/my_textfield.dart';
import 'package:main_sociavism/resources/add_data.dart';
import 'package:main_sociavism/utils.dart';

import '../components/my_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final newUsernameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final typeOfAccountController = TextEditingController();
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    String name = newUsernameController.text;
    String bio = descriptionController.text;
    String location = locationController.text;

    await StoreData().saveData(
      name: name,
      bio: bio,
      file: _image!,
      location: location,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Column(
        children: [
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
          SizedBox(height: 30),
          MyTextField(
              controller: newUsernameController,
              hintText: "Username",
              obscureText: false),
          SizedBox(
            height: 15,
          ),
          MyTextField(
              controller: descriptionController,
              hintText: "Account Description",
              obscureText: false),
          SizedBox(
            height: 15,
          ),
          MyTextField(
              controller: locationController,
              hintText: "Location",
              obscureText: false),
          SizedBox(
            height: 45,
          ),
          MyButton(onTap: saveProfile, text: "Save Profile"),
        ],
      ),
    );
  }
}
