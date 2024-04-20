import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import '../../../models/user_model.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/common_widgets/photo_widget.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/home_controller.dart';

class CreatePostPage extends GetView<HomeController> {
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
              key: controller.postFormKey,
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
                            controller.logout();
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
                            text: 'Create a new post',
                            style: smallTitle(),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    MultiplePhotoWidget(
                      controller: controller,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    TextWidget(
                      text: 'Write a caption *',
                      style: smallDescp(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    STextField(
                      textController: controller.captionController,
                      validate: Validator().required,
                      maxLength: 200,
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(3),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Event Mode",
                            style: smallDescp(),
                          ),
                          Switch(
                            activeTrackColor: ColorConstants.green,
                            activeColor: ColorConstants.darkGreen,
                            value: controller.isActive.value,
                            onChanged: (value) {
                              print(controller.isActive);
                              controller.switchIsActive(value);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    Obx(
                      () => controller.isActive.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: 'Participant limit *',
                                  style: smallDescp(),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: SizeConfig.getPercentSize(2),
                                ),
                                STextField(
                                  textController:
                                      controller.participantController,
                                  keyboardType: TextInputType.number,
                                  validate: Validator().required,
                                ),
                              ],
                            )
                          : SizedBox(),
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
                              text: "Upload",
                              width: double.infinity,
                              onTap: () => controller.createPost(),
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
