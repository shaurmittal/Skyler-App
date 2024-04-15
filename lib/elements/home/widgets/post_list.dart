import 'package:flutter/material.dart';

import '../../../utils/size/size_config.dart';
import 'post_widget.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
      child: ListView(
        children: [
          PostWidget(),
          PostWidget(),
          PostWidget(),
          PostWidget(),
        ],
      ),
    );
  }
}
