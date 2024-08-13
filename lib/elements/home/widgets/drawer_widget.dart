import 'package:findmyngo/constants/hive_constants.dart';
import 'package:findmyngo/elements/home/controller/home_controller.dart';
import 'package:findmyngo/elements/home/pages/create_mission.dart';
import 'package:findmyngo/elements/home/pages/faq_page.dart';
import 'package:findmyngo/elements/home/pages/home_page.dart';
import 'package:findmyngo/elements/home/pages/leaderboard_page.dart';
import 'package:findmyngo/elements/home/pages/missions_page.dart';
import 'package:findmyngo/elements/home/pages/ngo_profile_page.dart';
import 'package:findmyngo/elements/home/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

// Ignore the need for BuildContext in the constructor; it's not required here.
class DrawerWidget extends StatelessWidget {
  final HomeController controller;

  const DrawerWidget({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
      child: Drawer(
        width: SizeConfig.getPercentSize(70),
        backgroundColor: ColorConstants.lightGreen,
        child: SizedBox(
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
                title: TextWidget(
                  text: 'Home',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.to(() => const HomePage());
                },
              ),
              const SizedBox(
                height: 5,
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
              const SizedBox(
                height: 5,
              ),
              if (controller.isAdminId)
                ListTile(
                  leading: const LineIcon(
                    LineIcons.superpowers,
                    size: 35,
                    color: ColorConstants.darkGreen,
                  ),
                  title: TextWidget(
                    text: 'Post Mission',
                    style: smallTitle(),
                  ),
                  onTap: () {
                    Get.to(() => const CreateMissionPage());
                  },
                ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.switch_access_shortcut_rounded,
                  color: ColorConstants.darkGreen,
                  size: SizeConfig.getPercentSize(7),
                ),
                title: TextWidget(
                  text: 'FAQ',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.to(FAQScreen());
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.exclamationTriangle,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                title: TextWidget(
                  text: 'Missions',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.to(() => const MissionsPage());
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: const LineIcon(
                  LineIcons.crown,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                title: TextWidget(
                  text: 'Leaderboard',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.to(() => LeaderboardPage());
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              ListTile(
                leading: const LineIcon(
                  LineIcons.alternateSignOut,
                  size: 35,
                  color: ColorConstants.darkGreen,
                ),
                title: TextWidget(
                  text: 'Logout',
                  style: smallTitle(),
                ),
                onTap: () {
                  controller.logout();
                  // Optionally, navigate to another page after logout, e.g.,
                  // Get.off(() => LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
