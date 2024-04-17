import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/profile_photo_widget.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/user_controller.dart';

class NGODetailPage extends GetView<UserController> {
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
              key: controller.ngoDetailFormKey,
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
                            text: 'Fill out the required details.',
                            style: smallTitle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    ProfilePhotoWidget(
                      controller: controller,
                      title: 'Upload your logo or photo',
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    TextWidget(
                      text: 'NGO / Organization Name *',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoNameController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(3),
                    ),
                    TextWidget(
                      text: 'Summary *',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.aboutNgoController,
                      maxLength: 200,
                      maxLines: 4,
                      validate: Validator().required,
                    ),
                    TextWidget(
                      text: 'Location *',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoLocationController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: 'Phone number *',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoPhoneController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: 'Social Link (optional)',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoSocialController,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    SPlainButton(
                      text: "Submit",
                      width: double.infinity,
                      onTap: () {
                        Get.toNamed(Routes.HOME);
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
      ),
    );
  }
}
