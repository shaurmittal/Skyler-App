import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import 'package:main_sociavism/constants/hive_constants.dart';

import '../../../models/post_model.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/post_widget.dart';
import 'ngo_profile_page.dart';
import 'user_profile_page.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Get.back();
      },
      child: Scaffold(
        key: controller.scaffoldkey,
        appBar: AppBar(
          backgroundColor: ColorConstants.lightGreen,
          surfaceTintColor: ColorConstants.transparent,
          elevation: 0,
          toolbarHeight: SizeConfig.getPercentSize(20),
          leading: Padding(
            padding: EdgeInsets.only(left: SizeConfig.getPercentSize(4)),
            child: IconButton(
                onPressed: () {
                  controller.scaffoldkey.currentState!.openDrawer();
                },
                icon: LineIcon(
                  LineIcons.bars,
                  size: 37,
                  color: ColorConstants.darkGreen,
                )
                // Icon(
                //   CupertinoIcons.rectangle_grid_1x2_fill,
                //   // CupertinoIcons.line_horizontal_3,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                ),
          ),
          title: Row(
            children: [
              TextWidget(
                text: 'Find My NGO',
                style: title(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(2),
              ),
              Image.asset(
                'assets/earth.png',
                height: SizeConfig.getPercentSize(8),
                width: SizeConfig.getPercentSize(8),
                fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.getPercentSize(4)),
              child: IconButton(
                  onPressed: () {
                    if (getUserType() == UserType.USER.name) {
                      Get.to(() => UserProfilePage());
                      controller.setUser();
                    } else {
                      Get.to(() => NgoProfilePage());
                      controller.setNgo();
                    }
                  },
                  icon: LineIcon(
                    LineIcons.userCircle,
                    size: 39,
                    color: ColorConstants.darkGreen,
                  )
                  // Icon(
                  //   CupertinoIcons.profile_circled,
                  //   color: ColorConstants.darkGreen,
                  //   size: SizeConfig.getPercentSize(8),
                  // ),
                  ),
            ),
          ],
        ),
        drawer: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
            child: DrawerWidget(
              context: context,
              controller: controller,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getPercentSize(4),
            ),
            child: StreamBuilder<List<PostModel>>(
              stream: controller.getAllPosts(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkGreen,
                    ),
                  );
                } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                  print(snapshot.error);
                  return Center(
                    child: Container(
                      // height: SizeConfig.getPercentSize(20),
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(right: SizeConfig.getPercentSize(2)),
                      padding: EdgeInsets.all(SizeConfig.getPercentSize(3)),
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
                        'Something went wrong!\nTry again later...',
                        style: boldDesp(color: ColorConstants.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  List<PostModel> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostWidget(
                        post: posts[index],
                        controller: controller,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
