import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const FollowButton({super.key, required this.text, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.symmetric(horizontal: 100),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'LTSoul',
              color: Colors.black,
              fontSize: 21,
            ),
          ),
        ),
      ),
    );
  }
}
