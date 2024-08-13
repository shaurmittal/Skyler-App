import 'package:findmyngo/constants/hive_constants.dart';
import 'package:findmyngo/routes/app_pages.dart';
import 'package:findmyngo/utils/size/size_config.dart';
import 'package:findmyngo/utils/text/text_style.dart';
import 'package:findmyngo/utils/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future twoSecondDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (getLoggedIn()) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.SIGNUP);
    }
  }

  @override
  void initState() {
    twoSecondDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/dove2.png",
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            TextWidget(
              text: 'Skyler',
              style: smallTitle().copyWith(
                fontSize: SizeConfig.getPercentSize(8),
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
