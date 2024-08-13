import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/hive_constants.dart';
import '../../../models/post_model.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/post_widget.dart';
import 'ngo_profile_page.dart';
import 'user_profile_page.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Get.back();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.lightGreen,
          surfaceTintColor: ColorConstants.transparent,
          elevation: 0,
          toolbarHeight: SizeConfig.getPercentSize(20),
          centerTitle: false,
          title: const Text(
            "SKYLER",
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.getPercentSize(4)),
              child: IconButton(
                  onPressed: () {
                    if (getUserType() == UserType.USER.name) {
                      Get.to(() => UserProfilePage());
                      controller.setUser();
                    } else {
                      Get.to(() => NgoProfilePage());
                      controller.setNgo();
                    }
                  },
                  icon: const LineIcon(
                    LineIcons.dove,
                    size: 39,
                    color: ColorConstants.darkGreen,
                  )),
            ),
          ],
        ),
        drawer: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
            child: DrawerWidget(
              controller: controller,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getPercentSize(4),
            ),
            child: StreamBuilder<List<PostModel>>(
              stream: controller.getAllPosts(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkGreen,
                    ),
                  );
                } else if (snapshot.hasError || snapshot.data!.isEmpty) {
                  print(snapshot.error);
                  return Center(
                    child: Container(
                      // height: SizeConfig.getPercentSize(20),
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(right: SizeConfig.getPercentSize(2)),
                      padding: EdgeInsets.all(SizeConfig.getPercentSize(3)),
                      decoration: BoxDecoration(
                        color: ColorConstants.lightGreen,
                        border: Border.all(
                          color: ColorConstants.redAcc,
                          width: SizeConfig.getPercentSize(0.7),
                        ),
                        borderRadius: BorderRadius.circular(
                          SizeConfig.getPercentSize(3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.redAcc,
                            offset: Offset(
                              SizeConfig.getPercentSize(1.5),
                              SizeConfig.getPercentSize(1.5),
                            ),
                          ),
                        ],
                      ),
                      child: Text(
                        'Something went wrong!\nTry again later...',
                        style: boldDesp(color: ColorConstants.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  List<PostModel> posts = snapshot.data!;
                  return ListView.builder(
                    itemCount: posts.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostWidget(
                        post: posts[index],
                        controller: controller,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
