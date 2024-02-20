import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_sociavism/components/my_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotPWController = TextEditingController();

  @override
  void dispose() {
    forgotPWController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotPWController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text('Password reset link sent! Please check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Enter your email and we will send you a password reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
                controller: forgotPWController,
                hintText: "Enter your email",
                obscureText: false),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: passwordReset,
              child: Text("Reset Password"),
              color: Colors.deepPurple[200],
            )
          ],
        ));
  }
}
