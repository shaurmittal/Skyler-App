import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';

class ViewVolunteerPage extends GetView<HomeController> {
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
                          text: 'Volunteer Details',
                          style: boldBigTitle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SizeConfig.getPercentSize(2),
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: controller
                          .userList[controller.currentUserIndex.value]
                          .profilePhoto,
                      imageBuilder: (context, imageProvider) => Container(
                        height: SizeConfig.getPercentSize(35),
                        width: SizeConfig.getPercentSize(35),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => const Stack(
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: ColorConstants.darkGreen,
                            ),
                          ),
                        ],
                      ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: ColorConstants.darkGreen),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(4),
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
                        text: controller
                            .userList[controller.currentUserIndex.value].name,
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
                        text: controller
                            .userList[controller.currentUserIndex.value].age,
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
                        text: controller
                            .userList[controller.currentUserIndex.value]
                            .location,
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
                        text: controller
                            .userList[controller.currentUserIndex.value]
                            .phoneNo,
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
                      Expanded(
                        child: TextWidget(
                          text: controller
                              .userList[controller.currentUserIndex.value]
                              .socialLink,
                          style: boldTitle(),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                  SPlainButton(
                    text: "Remove Volunteer",
                    width: double.infinity,
                    onTap: () {
                      controller.userList
                          .removeAt(controller.currentUserIndex.value);
                      controller.removeVolunteer(
                          postId: controller.currentPostId.value);
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
