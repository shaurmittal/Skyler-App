import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/post_widget.dart';

class ProfilePage extends GetView<HomeController> {
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
        drawer: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
            child: DrawerWidget(context: context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                        onPressed: () {},
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
                          text: 'Profile',
                          style: boldBigTitle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                  PostWidget(),
                  SizedBox(
                    height: SizeConfig.getPercentSize(5),
                  ),
                  Container(
                    height: 100,
                    margin:
                        EdgeInsets.only(right: SizeConfig.getPercentSize(2)),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGreen,
                      border: Border.all(
                        color: ColorConstants.blue,
                        width: SizeConfig.getPercentSize(0.7),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.getPercentSize(3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.blue,
                          offset: Offset(
                            SizeConfig.getPercentSize(1.5),
                            SizeConfig.getPercentSize(1.5),
                          ),
                        ),
                      ],
                    ),
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
