import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/profile_photo_widget.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/user_controller.dart';

class UserDetailPage extends GetView<UserController> {
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
            child: Form(
              key: controller.userDetailFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getPercentSize(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: ColorConstants.darkGreen,
                            size: SizeConfig.getPercentSize(6),
                          ),
                        ),
                        Expanded(
                          child: TextWidget(
                            text: 'Almost there! Fill the details.',
                            style: smallTitle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    ProfilePhotoWidget(controller: controller),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    TextWidget(
                      text: 'First & Last Name',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.nameController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(3),
                    ),
                    TextWidget(
                      text: 'Age',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ageController,
                      keyboardType: TextInputType.number,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: 'Location',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.locationController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    SPlainButton(
                      text: "Save",
                      width: double.infinity,
                      onTap: () => controller.home(),
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
      ),
    );
  }
}
