import 'package:flutter/material.dart';
import 'package:main_sociavism/components/back_button.dart';
import 'package:main_sociavism/components/my_textfield.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers for form fields
  final eventNameController = TextEditingController();
  final eventLocationController = TextEditingController();

  // dispose
  @override
  void dispose() {
    eventNameController.dispose();
    eventLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 13),
                    child: MyBackButton(),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(child: Text("Media/Thumbnail Space")),
              const SizedBox(
                height: 40,
              ),
              MyTextField(
                  controller: eventNameController,
                  hintText: "Event Name",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                  controller: eventLocationController,
                  hintText: "Location",
                  obscureText: false),
            ],
          ),
        ),
      ),
    );
  }
}
