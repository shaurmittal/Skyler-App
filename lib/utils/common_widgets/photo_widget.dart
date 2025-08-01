import 'package:cached_network_image/cached_network_image.dart';
import 'package:findmyngo/elements/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../services/firebase_service.dart';
import '../size/size_config.dart';
import '../text/text_style.dart';

class ProfilePhotoWidget extends StatelessWidget {
  dynamic controller;
  String title;
  ProfilePhotoWidget({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(context) {
    return Obx(
      () => Center(
        child: SizedBox(
          height: SizeConfig.getPercentSize(45),
          width: SizeConfig.getPercentSize(45),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: ColorConstants.green,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: controller.isImageLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.darkGreen,
                    ),
                  )
                : controller.imageUrl.value != ""
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: controller.imageUrl.value,
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
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          getImageGallery(controller);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.photo,
                                size: SizeConfig.getPercentSize(15),
                                color: ColorConstants.darkGreen,
                              ),
                              SizedBox(
                                height: SizeConfig.getPercentSize(4),
                              ),
                              Text(
                                title,
                                style: smallButton(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MultiplePhotoWidget extends StatelessWidget {
  HomeController controller;
  MultiplePhotoWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(context) {
    return Obx(
      () => controller.isImageLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.darkGreen,
              ),
            )
          : controller.postImgUrl.isNotEmpty
              ? Center(
                  child: Container(
                    height: SizeConfig.getPercentSize(45),
                    width: SizeConfig.screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.postImgUrl.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.all(SizeConfig.getPercentSize(2)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.getPercentSize(3)),
                                child: CachedNetworkImage(
                                  imageUrl: controller.postImgUrl[index],
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
                                      const Icon(Icons.error,
                                          color: ColorConstants.darkGreen),
                                  // width: double.infinity,
                                  // height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.postImgUrl.removeAt(index);
                                },
                                child: CircleAvatar(
                                  backgroundColor: ColorConstants.redAcc,
                                  child: Icon(
                                    Icons.close,
                                    color: ColorConstants.white,
                                    size: SizeConfig.getPercentSize(5.5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    height: SizeConfig.getPercentSize(45),
                    width: SizeConfig.getPercentSize(45),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: ColorConstants.green,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          getImageListGallery(controller);
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.photo_fill_on_rectangle_fill,
                                size: SizeConfig.getPercentSize(15),
                                color: ColorConstants.darkGreen,
                              ),
                              SizedBox(
                                height: SizeConfig.getPercentSize(4),
                              ),
                              Text(
                                'Upload only 5 photos.',
                                style: smallButton(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
