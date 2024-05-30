import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import 'view_volunteer.dart';

class VolunteersPage extends GetView<HomeController> {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                      padding:
                          EdgeInsets.only(bottom: SizeConfig.getPercentSize(1)),
                      child: TextWidget(
                        text: 'Volunteers',
                        style: boldBigTitle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.getPercentSize(2),
                ),
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.darkGreen,
                          ),
                        )
                      : controller.userList.isEmpty
                          ? Center(
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    right: SizeConfig.getPercentSize(2)),
                                padding: EdgeInsets.all(
                                    SizeConfig.getPercentSize(3)),
                                decoration: BoxDecoration(
                                  color: ColorConstants.lightGreen,
                                  border: Border.all(
                                    color: ColorConstants.redAcc,
                                    width: SizeConfig.getPercentSize(0.7),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.getPercentSize(3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConstants.redAcc,
                                      offset: Offset(
                                        SizeConfig.getPercentSize(1.5),
                                        SizeConfig.getPercentSize(1.5),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Volunteers not found!',
                                  style: boldDesp(color: ColorConstants.red),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.userList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ViewVolunteerPage());
                                    controller.currentUserIndex(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: SizeConfig.getPercentSize(2)),
                                    padding: EdgeInsets.all(
                                        SizeConfig.getPercentSize(3)),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.lightGreen,
                                      border: Border.all(
                                        color: ColorConstants.darkGreen,
                                        width: SizeConfig.getPercentSize(0.7),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        SizeConfig.getPercentSize(3),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorConstants.darkGreen,
                                          offset: Offset(
                                            SizeConfig.getPercentSize(0.5),
                                            SizeConfig.getPercentSize(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: controller
                                              .userList[index].profilePhoto,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height:
                                                SizeConfig.getPercentSize(11),
                                            width:
                                                SizeConfig.getPercentSize(11),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Stack(
                                            children: [
                                              Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      ColorConstants.darkGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error,
                                                  color:
                                                      ColorConstants.darkGreen),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.getPercentSize(3),
                                        ),
                                        TextWidget(
                                          text: controller.userList[index].name,
                                          style: textField(),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          CupertinoIcons.right_chevron,
                                          color: ColorConstants.darkGreen,
                                          size: SizeConfig.getPercentSize(5),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
