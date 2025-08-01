import 'package:findmyngo/elements/home/widgets/custom_app_bar.dart';
import 'package:findmyngo/elements/home/widgets/mission_widget.dart';
import 'package:findmyngo/models/mission_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';

class MissionsPage extends GetView<HomeController> {
  const MissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Get.back();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: "Missions",
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
            child: StreamBuilder<List<MissionModel>>(
              stream: controller.getAllMissions(),
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
                  List<MissionModel> mission = snapshot.data!;
                  return ListView.builder(
                    itemCount: mission.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MissionWidget(
                        mission: mission[index],
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
