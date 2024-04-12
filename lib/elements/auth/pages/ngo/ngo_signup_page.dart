import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/buttons/buttons.dart';
import '../../../../utils/fields/textfield.dart';
import '../../../../utils/size/size_config.dart';
import '../../../../utils/text/text_widget.dart';
import '../../../../utils/text/text_style.dart';
import '../../../../utils/validators/text_field_validation.dart';
import '../../../user/pages/ngo_detail_page.dart';
import '../../controller/auth_controller.dart';

class NGOSignUpPage extends GetView<AuthController> {
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
              key: controller.ngoFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.getPercentSize(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    TextWidget(
                      text: 'Sociavism',
                      style: title(),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    TextWidget(
                      text: 'Jump in as a organization!',
                      style: smallTitle(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    Image.asset(
                      'assets/ngo.png',
                      height: SizeConfig.getPercentSize(50),
                      width: SizeConfig.getPercentSize(50),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(8),
                    ),
                    STextField(
                      textController: controller.emailController,
                      label: 'Email',
                      hint: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validate: Validator().validateEmail,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    Obx(
                      () => STextField(
                        textController: controller.passwordController,
                        label: 'Password',
                        hint: 'Password@123',
                        keyboardType: TextInputType.name,
                        validate: Validator().required,
                        icon: controller.isVisiblePass.value == false
                            ? Icon(
                                CupertinoIcons.eye_fill,
                                color: ColorConstants.darkGreen,
                                size: SizeConfig.getPercentSize(6),
                              )
                            : Icon(
                                CupertinoIcons.eye_slash_fill,
                                color: ColorConstants.darkGreen,
                                size: SizeConfig.getPercentSize(6),
                              ),
                        obscureText: controller.isVisiblePass.value,
                        onTapIcon: () {
                          controller
                              .setVisibiltyPass(controller.isVisiblePass.value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    SPlainButton(
                      text: "Sign Up",
                      width: double.infinity,
                      onTap: () => Get.toNamed(Routes.NGOUSERDETAILS),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(3),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: TextWidget(
                        text: "Have an account? Login",
                        style: textField(color: ColorConstants.darkGreen),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(10),
                    ),
                    SBorderedButton(
                      text: 'Not a NGO? Sign Up here',
                      onTap: () {
                        Get.back();
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
