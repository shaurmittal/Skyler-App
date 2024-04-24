import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/photo_widget.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/about_ngo.dart';
import 'create_post.dart';

class NgoProfilePage extends GetView<HomeController> {
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
                      padding:
                          EdgeInsets.only(bottom: SizeConfig.getPercentSize(1)),
                      child: TextWidget(
                        text: 'Profile',
                        style: boldBigTitle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    SPlainButton(
                      text: "Create",
                      height: SizeConfig.getPercentSize(10),
                      width: SizeConfig.getPercentSize(30),
                      btnTxtStl: smallButton(color: ColorConstants.white),
                      onTap: () {
                        Get.to(() => CreatePostPage());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.getPercentSize(5),
                ),
                ProfilePhotoWidget(
                  controller: controller,
                  title: 'Upload your logo or photo',
                ),
                SizedBox(
                  height: SizeConfig.getPercentSize(5),
                ),
                TabBar(
                  controller: controller.tabController,
                  indicatorColor: ColorConstants.darkGreen,
                  labelColor: ColorConstants.darkGreen,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: SizeConfig.getPercentSize(1),
                  dividerHeight: SizeConfig.getPercentSize(1),
                  //TODO: solve error & update from text styles
                  labelStyle: GoogleFonts.poppins(
                    fontSize: SizeConfig.getPercentSize(4.25),
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: SizeConfig.getPercentSize(4),
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(
                      text: 'About',
                    ),
                    Tab(
                      text: 'Post',
                    ),
                    Tab(
                      text: 'Events',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      AboutNgo(),
                      // PostList(),
                      // PostList(),
                    ],
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
