import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../constants/color_constants.dart';
import '../../../../utils/size/size_config.dart';
import '../controller/auth_controller.dart';

class PrivacyPolicyPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Get.back();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getPercentSize(4),
              vertical: SizeConfig.getPercentSize(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.getPercentSize(4),
                ),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorConstants.darkGreen,
                    size: SizeConfig.getPercentSize(6),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.getPercentSize(2),
                ),
                SizedBox(
                    height: SizeConfig.screenHeight! / 1.2,
                    width: SizeConfig.screenWidth,
                    child: WebViewWidget(controller: controller.webController)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
