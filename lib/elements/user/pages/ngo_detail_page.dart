import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../models/ngo_model.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/photo_widget.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/user_controller.dart';

class NGODetailPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Get.back();
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
                      text: 'NGO/Organization Name*',
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
                      text: 'Description*',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.aboutNgoController,
                      maxLength: 155,
                      maxLines: 4,
                      validate: Validator().required,
                    ),
                    TextWidget(
                      text: 'Location*',
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
                      text: 'Phone number*',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoPhoneController,
                      keyboardType: TextInputType.number,
                      validate: Validator().required,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: 'Social Link/Instagram ID*',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.ngoSocialController,
                      validate: null,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.darkGreen,
                              ),
                            )
                          : SPlainButton(
                              text: "Submit",
                              width: double.infinity,
                              onTap: () {
                                controller.addNGODetails(
                                  user: NgoModel(
                                    id: '',
                                    email: email,
                                    profilePhoto: controller.imageUrl.value,
                                    name: controller.ngoNameController.text,
                                    about: controller.aboutNgoController.text,
                                    location:
                                        controller.ngoLocationController.text,
                                    phoneNo: controller.ngoPhoneController.text,
                                    socialLink:
                                        controller.ngoSocialController.text,
                                    createdAt: DateTime.now().toString(),
                                    updatedAt: DateTime.now().toString(),
                                  ),
                                );
                              },
                            ),
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
