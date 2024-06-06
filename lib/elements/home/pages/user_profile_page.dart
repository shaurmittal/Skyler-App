import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import 'package:main_sociavism/elements/home/widgets/about_user.dart';

import '../../../utils/common_widgets/photo_widget.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../controller/home_controller.dart';

class UserProfilePage extends GetView<HomeController> {
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
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.darkGreen,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: SizeConfig.getPercentSize(8),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  CupertinoIcons.back,
                                  color: ColorConstants.darkGreen,
                                  size: SizeConfig.getPercentSize(7),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.getPercentSize(1),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.getPercentSize(1)),
                                child: TextWidget(
                                  text: 'Profile',
                                  style: boldBigTitle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          ProfilePhotoWidget(
                            controller: controller,
                            title: 'Upload your smiling photo',
                          ),
                          AboutUser(controller: controller),
                          SizedBox(
                            height: SizeConfig.getPercentSize(5),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
