import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/hive_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../pages/ngo_update_page.dart';
import '../pages/user_update_page.dart';

// ignore: must_be_immutable
class AboutUser extends StatelessWidget {
  var controller;
  AboutUser({
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.getPercentSize(8),
          ),
          Row(
            children: [
              const LineIcon(
                LineIcons.userAlt,
                size: 32,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(5),
              ),
              TextWidget(
                text: controller.nameController.text,
                style: boldTitle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
          controller.aboutNgoController.text == ''
              ? Row(
                  children: [
                    const LineIcon(
                      LineIcons.birthdayCake,
                      size: 32,
                    ),
                    SizedBox(
                      width: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: controller.ageController.text,
                      style: boldTitle(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  children: [
                    const LineIcon(
                      LineIcons.clipboardAlt,
                      size: 32,
                    ),
                    SizedBox(
                      width: SizeConfig.getPercentSize(5),
                    ),
                    Expanded(
                      child: TextWidget(
                        text: controller.aboutNgoController.text,
                        style: boldTitle(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
          Row(
            children: [
              const LineIcon(
                LineIcons.alternateMapMarked,
                size: 32,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(5),
              ),
              TextWidget(
                text: controller.locationController.text,
                style: boldTitle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
          Row(
            children: [
              const LineIcon(
                LineIcons.mobilePhone,
                size: 32,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(5),
              ),
              TextWidget(
                text: controller.phoneController.text,
                style: boldTitle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
          controller.socialController.text == ''
              ? Row(
                  children: [
                    const LineIcon(
                      LineIcons.globe,
                      size: 32,
                    ),
                    SizedBox(
                      width: SizeConfig.getPercentSize(5),
                    ),
                    Expanded(
                      child: TextWidget(
                        text: controller.socialController.text,
                        style: boldTitle(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.socialController.text == ''
              ? SizedBox(
                  height: SizeConfig.getPercentSize(5),
                )
              : const SizedBox(),
          SPlainButton(
            text: "Edit Profile",
            width: double.infinity,
            onTap: () {
              if (getUserType() == UserType.USER.name) {
                Get.to(() => UserUpdatePage());
              } else {
                Get.to(() => NgoUpdatePage());
              }
            },
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
          SPlainButton(
            text: "Delete Profile",
            width: double.infinity,
            onTap: () {
              controller.deleteUser();
              Get.back();
            },
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(5),
          ),
        ],
      ),
    );
  }
}
