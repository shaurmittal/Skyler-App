import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

class AboutNgo extends StatelessWidget {
  const AboutNgo({super.key});

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
              text: 'Rohan Veer',
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
              Icons.cake_rounded,
              color: ColorConstants.darkGreen,
              size: SizeConfig.getPercentSize(7),
            ),
            SizedBox(
              width: SizeConfig.getPercentSize(5),
            ),
            TextWidget(
              text: '20',
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
              text: 'Mumbai, Maharashtra',
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
              text: '+91 93XXXXXXXX',
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
              // Icons.south_america_outlined,
              CupertinoIcons.globe,
              color: ColorConstants.darkGreen,
              size: SizeConfig.getPercentSize(7),
            ),
            SizedBox(
              width: SizeConfig.getPercentSize(5),
            ),
            TextWidget(
              text: 'rohanveer_99',
              style: boldTitle(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.getPercentSize(5),
        ),
        SPlainButton(
          text: "Edit Profile",
          width: double.infinity,
          onTap: () {
            Get.toNamed(Routes.NGOUSERDETAILS);
          },
        ),
        SizedBox(
          height: SizeConfig.getPercentSize(5),
        ),
      ],
    );
  }
}
