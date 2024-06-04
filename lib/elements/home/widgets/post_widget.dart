import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../models/post_model.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final controller;
  PostWidget({
    required this.post,
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
          color: post.isEvent == true
              ? ColorConstants.green
              : ColorConstants.darkGreen,
          width: SizeConfig.getPercentSize(0.7),
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.getPercentSize(3),
        ),
        boxShadow: [
          BoxShadow(
            color: post.isEvent == true
                ? ColorConstants.green
                : ColorConstants.darkGreen,
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
                imageUrl: post.creator.profilePhoto,
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
                    text: post.creator.name,
                    style: boldTitle(),
                  ),
                  TextWidget(
                    text: controller.setDate(post.createdAt),
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
            text: post.caption,
            style: boldDesp(),
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(2),
          ),
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
            itemCount: post.images.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConfig.getPercentSize(3)),
                child: CachedNetworkImage(
                  imageUrl: post.images[index],
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
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: ColorConstants.darkGreen),
                  // width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(3),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // Image.asset(
          //   'assets/share.png',
          //   height: SizeConfig.getPercentSize(10),
          //   width: SizeConfig.getPercentSize(10),
          //   fit: BoxFit.cover,
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(
          //     vertical: SizeConfig.getPercentSize(2),
          //     horizontal: SizeConfig.getPercentSize(3),
          //   ),
          //   decoration: BoxDecoration(
          //     color: ColorConstants.lightGreen,
          //     border: Border.all(
          //       color: ColorConstants.green,
          //       width: SizeConfig.getPercentSize(0.7),
          //     ),
          //     borderRadius: BorderRadius.circular(
          //       SizeConfig.getPercentSize(3),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(
          //         CupertinoIcons.share,
          //         color: ColorConstants.darkGreen,
          //         size: SizeConfig.getPercentSize(6),
          //       ),
          //       SizedBox(
          //         width: SizeConfig.getPercentSize(2),
          //       ),
          //       TextWidget(
          //         text: "Share",
          //         style: boldDesp(),
          //       ),
          //     ],
          //   ),
          // ),
          post.isEvent == true
              ? Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      controller.handleVolunteer(post);
                    },
                    child: Container(
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
                            text: "Volunteer",
                            style: boldDesp(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
