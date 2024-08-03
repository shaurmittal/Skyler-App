import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/color_constants.dart';
import '../size/size_config.dart';
import '../text/text_widget.dart';
import '../text/text_style.dart';

class SPlainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final btnTxtStl;
  const SPlainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnTxtStl,
    this.height,
    this.width,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? SizeConfig.getPercentSize(15),
        width: width ?? SizeConfig.getPercentSize(90),
        // margin: margin ??
        //     EdgeInsets.all(
        //       SizeConfig.getPercentSize(2),
        //     ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstants.darkGreen,
          borderRadius: BorderRadius.circular(
            SizeConfig.getPercentSize(3),
          ),
        ),
        child: TextWidget(
          text: text,
          style: btnTxtStl ?? largeButton(),
        ),
      ),
    );
  }
}

class SBorderedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String? image;
  final double? height;
  final double? width;
  final Color? btnTxtColor;

  const SBorderedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.image,
    this.height,
    this.width,
    this.btnTxtColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? SizeConfig.getPercentSize(14),
        width: width ?? SizeConfig.getPercentSize(90),
        margin: EdgeInsets.all(
          SizeConfig.getPercentSize(2),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // color: ColorConstants.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(
            SizeConfig.getPercentSize(3),
          ),
          border: Border.all(
            width: SizeConfig.getPercentSize(0.5),
            color: ColorConstants.darkGreen,
          ),
        ),
        child: TextWidget(
          text: text,
          style: smallButton(),
        ),
      ),
    );
  }
}
