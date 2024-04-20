import 'package:main_sociavism/models/user_model.dart';

class PostModel {
   final String id;
 final String profilePhoto;
  final String name;
  final String postDate;
  final String caption;
  final List<String> images;
  final List<UserModel> volunteers;
  final int volunteerLimit;
  final bool isEvent;
  final String createdAt;
  final String updatedAt;

  PostModel({
    required this.id,
    required this.profilePhoto,
    required this.name,
    required this.postDate,
    required this.caption,
    required this.images,
    required this.volunteers,
    required this.volunteerLimit,
    required this.isEvent,
    required this.createdAt,
    required this.updatedAt,
  });
}
