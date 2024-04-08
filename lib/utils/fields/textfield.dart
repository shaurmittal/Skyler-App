import 'package:flutter/material.dart';
import '../text/text_style.dart';
import 'theme_helper.dart';

class STextField extends StatelessWidget {
  var textController;
  String? label;
  String? hint;
  Widget? icon;
  var onTapIcon;
  var keyboardType;
  var validate;
  var readOnly;
  var onTap;
  var maxLines;
  var obscureText;
  STextField({
    required this.textController,
    this.label,
    this.hint,
    this.icon,
    this.onTapIcon,
    this.keyboardType,
    required this.validate,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      style: textField(),
      validator: validate,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      obscureText: obscureText ?? false,
      decoration: ThemeHelper(context: context).textInputDecoration(
        label ?? "",
        hint ?? "",
        icon,
        onTapIcon,
      ),
    );
  }
}
