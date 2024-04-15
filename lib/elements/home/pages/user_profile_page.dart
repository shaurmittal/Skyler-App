import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/profile_photo_widget.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';

class UserProfilePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        final NavigatorState navigator = Navigator.of(context);
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getPercentSize(4),
            ),
            child: SingleChildScrollView(
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
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                  ProfilePhotoWidget(
                    controller: controller,
                    title: 'Upload your smiling photo',
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(8),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
          child: SPlainButton(
            text: "Edit Profile",
            width: double.infinity,
            onTap: () {
              Get.toNamed(Routes.USERDETAILS);
            },
          ),
        ),
      ),
    );
  }
}
