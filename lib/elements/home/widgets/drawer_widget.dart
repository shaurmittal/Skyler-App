import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';

import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

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
                leading: Icon(
                  CupertinoIcons.home,
                  color: ColorConstants.darkGreen,
                  size: SizeConfig.getPercentSize(7),
                ),
                title: TextWidget(
                  text: 'Home',
                  style: smallTitle(),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.developer_mode_sharp,
                  color: ColorConstants.darkGreen,
                  size: SizeConfig.getPercentSize(7),
                ),
                title: TextWidget(
                  text: 'About Us',
                  style: smallTitle(),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.switch_access_shortcut_rounded,
                  color: ColorConstants.darkGreen,
                  size: SizeConfig.getPercentSize(7),
                ),
                title: TextWidget(
                  text: 'Invite',
                  style: smallTitle(),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: ColorConstants.darkGreen,
                  size: SizeConfig.getPercentSize(7),
                ),
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
