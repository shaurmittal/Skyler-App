import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/profile_photo_widget.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.rectangle_grid_1x2_fill,
                          // CupertinoIcons.line_horizontal_3,
                          color: ColorConstants.darkGreen,
                          size: SizeConfig.getPercentSize(7),
                        ),
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Sociavism',
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
                      IconButton(
                        onPressed: () {
                          // Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.profile_circled,
                          color: ColorConstants.darkGreen,
                          size: SizeConfig.getPercentSize(8),
                        ),
                      ),
                    ],
                  ),
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
                            SizeConfig.getPercentSize(1.5),
                            SizeConfig.getPercentSize(1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
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
