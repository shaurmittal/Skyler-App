import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../size/size_config.dart';
import '../text/text_style.dart';

class ThemeHelper {
  BuildContext context;
  ThemeHelper({required this.context});
  InputDecoration textInputDecoration([
    String lableText = "",
    String hintText = "",
    Widget? suffixIcon,
    VoidCallback? onTapIcon,
  ]) {
    return InputDecoration(
      labelText: lableText,
      labelStyle: textField(color: ColorConstants.darkGreen),
      hintText: hintText,
      hintStyle: hintField(),
      errorMaxLines: 3,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: ColorConstants.transparent,
      border: InputBorder.none,
      suffixIcon: Padding(
        padding: EdgeInsets.all(SizeConfig.getPercentSize(1)),
        child: IconButton(
          icon: suffixIcon ?? const Icon(null),
          color: ColorConstants.darkGreen,
          onPressed: onTapIcon,
        ),
      ),
      filled: true,
      // contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      contentPadding: EdgeInsets.only(
        top: SizeConfig.getPercentSize(0.5),
        left: SizeConfig.getPercentSize(4),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: ColorConstants.darkGreen,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: ColorConstants.darkGreen,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: ColorConstants.redAcc,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SizeConfig.getPercentSize(3)),
        borderSide: BorderSide(
          color: ColorConstants.redAcc,
          width: 2,
        ),
      ),
    );
  }
}
