import 'package:findmyngo/models/mission_model.dart';
import 'package:findmyngo/utils/common_widgets/photo_widget.dart';
import 'package:findmyngo/utils/common_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/buttons/buttons.dart';
import '../../../utils/fields/textfield.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../../../utils/validators/text_field_validation.dart';
import '../controller/home_controller.dart';

class CreateMissionPage extends GetView<HomeController> {
  const CreateMissionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
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
                            text: 'Create a new mission',
                            style: smallTitle(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    MultiplePhotoWidget(
                      controller: controller,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    TextWidget(
                      text: 'Write a caption*',
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
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Ngo limit*',
                          style: smallDescp(),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: SizeConfig.getPercentSize(2),
                        ),
                        STextField(
                          textController: controller.participantController,
                          keyboardType: TextInputType.number,
                          validate: Validator().required,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.darkGreen,
                              ),
                            )
                          : SPlainButton(
                              text: "Upload",
                              width: double.infinity,
                              onTap: () async {
                                // Manual validation
                                String caption =
                                    controller.captionController.text.trim();
                                String participantLimitText = controller
                                    .participantController.text
                                    .trim();

                                if (caption.isEmpty ||
                                    participantLimitText.isEmpty) {
                                  // Show error if fields are empty
                                  showAppSnackBar(
                                    message: 'Please fill all required fields.',
                                    toastType: ToastType.error,
                                  );
                                  return;
                                }

                                int? participantLimit;
                                try {
                                  participantLimit =
                                      int.parse(participantLimitText);
                                } catch (e) {
                                  // Show error if participant limit is not a valid number
                                  showAppSnackBar(
                                    message:
                                        'Participant limit must be a valid number.',
                                    toastType: ToastType.error,
                                  );
                                  return;
                                }
                               
                                // Proceed with mission creation
                                controller.createMission(
                                  mission: MissionModel(
                                    id: '',
                                    caption: caption,
                                    images: controller.postImgUrl.cast(),
                                    creator: await controller.getNgoDetails(),
                                    creatorId: await controller.getUserId(),
                                    ngoLimit: controller.isActive.value
                                        ? participantLimit
                                        : 0,
                                    ngoVolunteers: [],
                                    ngoVolunteersId: [],
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
