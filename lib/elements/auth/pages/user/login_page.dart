import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../../utils/buttons/buttons.dart';
import '../../../../utils/fields/textfield.dart';
import '../../../../utils/size/size_config.dart';
import '../../../../utils/text/text_style.dart';
import '../../../../utils/text/text_widget.dart';
import '../../../../utils/validators/text_field_validation.dart';
import '../../controller/auth_controller.dart';
import '../ngo/ngo_signup_page.dart';

class LoginPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
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
              key: controller.loginFormKey,
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
                      text: 'SKYLER',
                      style: title(),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(2),
                    ),
                    TextWidget(
                      text: 'Welcome Back! Login as a User.',
                      style: smallTitle(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(5),
                    ),
                    Image.asset(
                      'assets/dove2.png',
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
                        validate: Validator().password,
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
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.darkGreen,
                              ),
                            )
                          : SPlainButton(
                              text: "Login",
                              width: double.infinity,
                              onTap: () => controller.login(isNGO: false),
                            ),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(3),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: TextWidget(
                        text: "New here? Sign Up",
                        style: textField(color: ColorConstants.darkGreen),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.getPercentSize(10),
                    ),
                    SBorderedButton(
                      text: 'Join as an NGO',
                      onTap: () {
                        Get.to(() => NGOSignUpPage());
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
