import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:findmyngo/elements/home/controller/home_controller.dart';
import 'package:findmyngo/models/mission_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

class MissionWidget extends StatelessWidget {
  final MissionModel mission;
  final HomeController controller;
  MissionWidget({
    required this.mission,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.getPercentSize(2.5)),
      margin: EdgeInsets.only(
        right: SizeConfig.getPercentSize(2),
        bottom: SizeConfig.getPercentSize(4),
      ),
      decoration: BoxDecoration(
        color: ColorConstants.lightGreen,
        border: Border.all(
          color: ColorConstants.green,
          width: SizeConfig.getPercentSize(0.7),
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.getPercentSize(3),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.green,
            offset: Offset(
              SizeConfig.getPercentSize(1.5),
              SizeConfig.getPercentSize(1.5),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: mission.creator.profilePhoto,
                imageBuilder: (context, imageProvider) => Container(
                  height: SizeConfig.getPercentSize(9),
                  width: SizeConfig.getPercentSize(9),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.darkGreen,
                      ),
                    ),
                  ],
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: ColorConstants.darkGreen),
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: mission.creator.name,
                    style: boldTitle(),
                  ),
                  TextWidget(
                    text: controller.setDate(mission.createdAt),
                    style: smallHelperStyle(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(2),
          ),
          TextWidget(
            text: mission.caption,
            style: boldDesp(),
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(2),
          ),
          if (mission.images.isNotEmpty)
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: SizeConfig.getPercentSize(35),
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 0.5,
                  // reverse: true,
                  onPageChanged: (index, reason) {
                    // controller.activeIndex(index).toInt();
                  }),
              itemCount: mission.images.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius:
                      BorderRadius.circular(SizeConfig.getPercentSize(3)),
                  child: CachedNetworkImage(
                    imageUrl: mission.images[index] ?? "",
                    width: double.infinity,
                    placeholder: (context, url) => const Stack(
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: ColorConstants.darkGreen,
                          ),
                        ),
                      ],
                    ),
                    errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: ColorConstants.darkGreen),
                    // width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          SizedBox(
            height: SizeConfig.getPercentSize(3),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                controller.handleNgoVolunteer(mission);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: SizeConfig.getPercentSize(40),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.getPercentSize(1),
                      horizontal: SizeConfig.getPercentSize(3),
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightGreen,
                      border: Border.all(
                        color: ColorConstants.green,
                        width: SizeConfig.getPercentSize(0.7),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.getPercentSize(3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/bid.png',
                          height: SizeConfig.getPercentSize(8),
                          width: SizeConfig.getPercentSize(8),
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: SizeConfig.getPercentSize(2),
                        ),
                        TextWidget(
                            text: "ACTIVATE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ],
                    ),
                  ),
                  if (mission.ngoVolunteers.isNotEmpty &&
                      mission.ngoVolunteers
                          .contains(controller.currentUser?.uid ?? ""))
                    IconButton(
                      onPressed: () {
                        controller.addPointsAndGemsInNgoProfile(mission);
                      },
                      icon: Icon(
                        Icons.check_circle,
                        size: SizeConfig.getPercentSize(7),
                        color: Colors.green.shade400,
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
