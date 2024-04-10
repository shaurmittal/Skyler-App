import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_sociavism/constants/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:main_sociavism/utils/text/text_style.dart';
import '../../services/firebase_service.dart';
import '../size/size_config.dart';

class ProfilePhotoWidget extends StatelessWidget {
  dynamic controller;
  ProfilePhotoWidget({required this.controller});

  @override
  Widget build(context) {
    return Obx(
      () => Center(
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
            child: controller.imageUrl.value != ""
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: controller.imageUrl.value,
                          placeholder: (context, url) => Stack(
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  color: ColorConstants.darkGreen,
                                ),
                              ),
                            ],
                          ),
                          errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: ColorConstants.darkGreen),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.photo,
                              size: SizeConfig.getPercentSize(5),
                            ),
                            color: ColorConstants.darkGreen,
                            onPressed: () {
                              getImageGallery(controller);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
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
                            'Upload your smiling photo',
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
