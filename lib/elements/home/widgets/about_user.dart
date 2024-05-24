import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

class AboutUser extends StatelessWidget {
  var controller;
  AboutUser({
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.getPercentSize(8),
        ),
        Row(
          children: [
            Icon(
              CupertinoIcons.person_solid,
              color: ColorConstants.darkGreen,
              size: SizeConfig.getPercentSize(7),
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
                  Icon(
                    Icons.cake_rounded,
                    color: ColorConstants.darkGreen,
                    size: SizeConfig.getPercentSize(7),
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
                  Icon(
                    Icons.summarize_rounded,
                    color: ColorConstants.darkGreen,
                    size: SizeConfig.getPercentSize(7),
                  ),
                  SizedBox(
                    width: SizeConfig.getPercentSize(5),
                  ),
                  TextWidget(
                    text: controller.aboutNgoController.text,
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
            Icon(
              CupertinoIcons.location_solid,
              color: ColorConstants.darkGreen,
              size: SizeConfig.getPercentSize(7),
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
            Icon(
              CupertinoIcons.phone_fill,
              color: ColorConstants.darkGreen,
              size: SizeConfig.getPercentSize(7),
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
                  Icon(
                    // Icons.south_america_outlined,
                    CupertinoIcons.globe,
                    color: ColorConstants.darkGreen,
                    size: SizeConfig.getPercentSize(7),
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
            : SizedBox(),
        controller.socialController.text == ''
            ? SizedBox(
                height: SizeConfig.getPercentSize(5),
              )
            : SizedBox(),
        SPlainButton(
          text: "Edit Profile",
          width: double.infinity,
          onTap: () {
            // Get.toNamed(Routes.NGOUSERDETAILS);
          },
        ),
        SizedBox(
          height: SizeConfig.getPercentSize(5),
        ),
      ],
    );
  }
}
