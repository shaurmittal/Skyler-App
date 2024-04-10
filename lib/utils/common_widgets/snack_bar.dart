import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';

import '../size/size_config.dart';
import '../text/text_style.dart';

enum ToastType {
  success,
  theme,
  error,
  warning,
  info,
}

void showAppSnackBar({
  required String message,
  ToastType toastType = ToastType.success,
  int duration = 3,
  IconData? icon,
  Color? backgroundColor,
}) {
  switch (toastType) {
    case ToastType.success:
      icon = Icons.check;
      backgroundColor = ColorConstants.darkGreen.withOpacity(0.8);
      break;
    case ToastType.error:
      icon = Icons.close;
      backgroundColor = Colors.red[400]!.withOpacity(0.8);
      break;
    case ToastType.theme:
      icon = Icons.check_box;
      backgroundColor = ColorConstants.darkGreen.withOpacity(0.8);
      break;
    case ToastType.warning:
      icon = Icons.warning;
      backgroundColor = Colors.orange[400]!.withOpacity(0.8);
      break;
    case ToastType.info:
      icon = Icons.info_outline;
      backgroundColor = Colors.yellow[400]!.withOpacity(0.8);
      break;
  }

  GetSnackBar snackBar = GetSnackBar(
    duration: Duration(seconds: duration),
    borderRadius: SizeConfig.getPercentSize(5),
    messageText: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: SizeConfig.getPercentSize(10),
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(
          //     horizontal: SizeConfig.getPercentSize1(screenWidth, 0)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.getPercentSize(6),
              ),
              SizedBox(
                height: SizeConfig.getPercentSize(6),
                child: Icon(
                  icon,
                  color: ColorConstants.white,
                  size: SizeConfig.getPercentSize(5),
                ),
              ).paddingOnly(right: SizeConfig.getPercentSize(5)),
              Text(
                message,
                style: smallButton(color: ColorConstants.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    margin: EdgeInsets.symmetric(horizontal: SizeConfig.getPercentSize(1)),
    snackStyle: SnackStyle.GROUNDED,
  );

  Get.showSnackbar(snackBar);
}
