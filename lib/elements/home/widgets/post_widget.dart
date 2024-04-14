import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';
import '../../../utils/size/size_config.dart';
import '../../../utils/text/text_style.dart';
import '../../../utils/text/text_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.getPercentSize(2.5)),
      margin: EdgeInsets.only(right: SizeConfig.getPercentSize(2)),
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
        children: [
          Row(
            children: [
              Image.asset(
                'assets/earth.png',
                height: SizeConfig.getPercentSize(8),
                width: SizeConfig.getPercentSize(8),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: SizeConfig.getPercentSize(3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Rohan Veer',
                    style: boldTitle(),
                  ),
                  TextWidget(
                    text: '14/04/2024',
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
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
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
                // reverse: true,
                onPageChanged: (index, reason) {
                  // controller.activeIndex(index).toInt();
                }),
            itemCount: imgList.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConfig.getPercentSize(3)),
                child: Image.asset(
                  imgList[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(
            height: SizeConfig.getPercentSize(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/share.png',
                height: SizeConfig.getPercentSize(10),
                width: SizeConfig.getPercentSize(10),
                fit: BoxFit.cover,
              ),
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
              Container(
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
            ],
          ),
        ],
      ),
    );
  }
}

var imgList = [
  'assets/img1.png',
  'assets/img2.jpeg',
  'assets/img3.jpg',
  'assets/img4.jpg',
];
