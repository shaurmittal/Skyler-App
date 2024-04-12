import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../size/size_config.dart';

TextStyle title() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(8),
    fontWeight: FontWeight.bold,
    color: ColorConstants.darkGreen,
    // letterSpacing: 1.1,
    // shadows: [
    //   Shadow(
    //     color: ColorConstants.green,
    //     offset: Offset(4, 2),
    //     blurRadius: 8,
    //   ),
    // ],
  );
}

TextStyle smallTitle() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(5),
    fontWeight: FontWeight.w500,
    color: ColorConstants.darkGreen,
  );
}

TextStyle descp() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.25),
    fontWeight: FontWeight.w600,
    color: ColorConstants.darkGreen,
  );
}

TextStyle smallDescp({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.darkGreen,
  );
}

TextStyle textField({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.5),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.darkGreen,
  );
}

TextStyle hintField() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.5),
    fontWeight: FontWeight.w500,
    color: ColorConstants.green,
  );
}

TextStyle largeButton() {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(5.4),
    fontWeight: FontWeight.w500,
    color: ColorConstants.lightGreen,
  );
}

TextStyle smallButton({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(4.5),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.darkGreen,
  );
}

TextStyle smallHelperStyle({Color? color}) {
  return TextStyle(
    fontSize: SizeConfig.getPercentSize(3.4),
    fontWeight: FontWeight.w500,
    color: color ?? ColorConstants.darkGreen,
  );
}
