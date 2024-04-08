import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../constants/color_constants.dart';
import '../size/size_config.dart';
import '../text/small_widgets.dart';
import '../text/text_style.dart';

class SPlainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const SPlainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.getPercentSize(15),
        width: width ?? SizeConfig.getPercentSize(80),
        margin: margin ??
            EdgeInsets.all(
              SizeConfig.getPercentSize(2),
            ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorConstants.darkGreen,
          borderRadius: BorderRadius.circular(
            SizeConfig.getPercentSize(3),
          ),
        ),
        child: TextWidget(
          text: text,
          style: largeButton(),
        ),
      ),
    );
  }
}
