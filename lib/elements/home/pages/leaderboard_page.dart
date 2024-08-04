import 'package:findmyngo/models/ngo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';
import '../controller/home_controller.dart';
import '../widgets/drawer_widget.dart';

class LeaderboardPage extends GetView<HomeController> {
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
          title: Row(
            children: [
              TextWidget(
                text: 'Leaderboard',
                style: title(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(2),
              ),
            ],
          ),
        ),
        drawer: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.getPercentSize(4)),
            child: DrawerWidget(
              context: context,
              controller: controller,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getPercentSize(4),
            ),
            child: StreamBuilder<List<NgoModel>>(
              stream: controller.getTop10NgoWithPoints(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkGreen,
                    ),
                  );
                } else if (snapshot.hasError || snapshot.data!.isEmpty) {
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
                        'No Leaderboard Found',
                        style: boldDesp(color: ColorConstants.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  List<NgoModel> leaderboard = snapshot.data!;
                  return Container(
                    padding: EdgeInsets.all(SizeConfig.getPercentSize(2.5)),
                    margin: EdgeInsets.only(
                      right: SizeConfig.getPercentSize(2),
                      bottom: SizeConfig.getPercentSize(4),
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGreen,
                      border: Border.all(
                        color: ColorConstants.darkGreen,
                        width: SizeConfig.getPercentSize(0.7),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.getPercentSize(3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.darkGreen,
                          offset: Offset(
                            SizeConfig.getPercentSize(1.5),
                            SizeConfig.getPercentSize(1.5),
                          ),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            leading: TextWidget(
                              text: '#',
                              style: smallDescp(),
                            ),
                            title: TextWidget(
                              text: 'Name',
                              style: smallDescp(),
                            ),
                            trailing: Container(
                              width: 135,
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: 'Points',
                                    style: smallDescp(),
                                  ),
                                  const Spacer(),
                                  TextWidget(
                                    text: 'Gems',
                                    style: smallDescp(),
                                  ),
                                ],
                              ),
                            )),
                        ListView.builder(
                          itemCount: leaderboard.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: SizeConfig.getPercentSize(2.5),
                              ),
                              padding: EdgeInsets.all(
                                  SizeConfig.getPercentSize(2.5)),
                              decoration: BoxDecoration(
                                color: ColorConstants.lightGreen,
                                border: Border.all(
                                  color: ColorConstants.darkGreen,
                                  width: SizeConfig.getPercentSize(0.7),
                                ),
                                borderRadius: BorderRadius.circular(
                                  SizeConfig.getPercentSize(3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstants.darkGreen,
                                    offset: Offset(
                                      SizeConfig.getPercentSize(1.0),
                                      SizeConfig.getPercentSize(1.0),
                                    ),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: TextWidget(
                                  text: (index + 1).toString(),
                                  style: smallDescp().copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: TextWidget(
                                  text: leaderboard[index].name,
                                  style: smallDescp(),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: leaderboard[index]
                                            .points
                                            .toString(),
                                        style: smallDescp2(),
                                      ),
                                      const Spacer(),
                                      TextWidget(
                                        text:
                                            leaderboard[index].gems.toString(),
                                        style: smallDescp2(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
