import 'package:findmyngo/constants/hive_constants.dart';
import 'package:findmyngo/elements/home/pages/ngo_profile_page.dart';
import 'package:findmyngo/elements/home/pages/user_profile_page.dart';
import 'package:findmyngo/utils/common_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  BuildContext context;
  var controller;
  DrawerWidget({
    required this.context,
    required this.controller,
    super.key,
  });

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
      child: Drawer(
        width: SizeConfig.getPercentSize(70),
        backgroundColor: ColorConstants.lightGreen,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              SizedBox(
                height: SizeConfig.getPercentSize(2),
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.home,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                // Icon(
                //   CupertinoIcons.home,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                title: TextWidget(
                  text: 'Home',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.user,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                title: TextWidget(
                  text: 'Profile',
                  style: smallTitle(),
                ),
                onTap: () {
                  if (getUserType() == UserType.USER.name) {
                    Get.to(() => UserProfilePage());
                    controller.setUser();
                  } else {
                    Get.to(() => NgoProfilePage());
                    controller.setNgo();
                  }
                },
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // ListTile(
              //   leading: LineIcon(
              //     LineIcons.infoCircle,
              //     size: 35,
              //     color: ColorConstants.darkGreen,
              //   ),
              //   // Icon(
              //   //   Icons.developer_mode_sharp,
              //   //   color: ColorConstants.darkGreen,
              //   //   size: SizeConfig.getPercentSize(7),
              //   // ),
              //   title: TextWidget(
              //     text: 'About Us',
              //     style: smallTitle(),
              //   ),
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.switch_access_shortcut_rounded,
              //     color: ColorConstants.darkGreen,
              //     size: SizeConfig.getPercentSize(7),
              //   ),
              //   title: TextWidget(
              //     text: 'Invite',
              //     style: smallTitle(),
              //   ),
              //   onTap: () {},
              // ),
              // SizedBox(
              //   height: 5,
              // ),

              SizedBox(
                height: SizeConfig.getPercentSize(2),
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.exclamationTriangle,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                // Icon(
                //   CupertinoIcons.home,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                title: TextWidget(
                  text: 'Missions',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: SizeConfig.getPercentSize(2),
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.gem,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                // Icon(
                //   CupertinoIcons.home,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                title: TextWidget(
                  text: 'Credit System',
                  style: smallTitle(),
                ),
                onTap: () {
                  controller.showSnackBar(context,
                      'This feature will be available soon!', ToastType.info);
                  Get.back();
                },
              ),
              SizedBox(
                height: SizeConfig.getPercentSize(2),
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.crown,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                // Icon(
                //   CupertinoIcons.home,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                title: TextWidget(
                  text: 'Leaderboard',
                  style: smallTitle(),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This feature will be available soon!'),
                    ),
                  );
                  Get.back();
                },
              ),
              const Divider(),
              ListTile(
                leading: const LineIcon(
                  LineIcons.alternateSignOut,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                // Icon(
                //   Icons.logout_rounded,
                //   color: ColorConstants.darkGreen,
                //   size: SizeConfig.getPercentSize(7),
                // ),
                title: TextWidget(
                  text: 'Logout',
                  style: smallTitle(),
                ),
                onTap: () {
                  controller.logout();
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
