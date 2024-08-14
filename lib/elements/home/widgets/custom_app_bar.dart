import 'package:findmyngo/utils/size/size_config.dart';
import 'package:findmyngo/utils/text/text_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final Widget? iconWidget;
  final Widget? bottom;

  const CustomAppBar(
      {super.key, required this.titleText, this.iconWidget, this.bottom});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Text(
                titleText,
                style: smallTitle(),
              ),
              const Spacer(),
              iconWidget ?? Container(),
            ],
          ),
          bottom ?? Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.getPercentSize(bottom == null ? 15 : 25));
}
