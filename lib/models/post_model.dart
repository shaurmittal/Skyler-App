import 'package:main_sociavism/models/ngo_model.dart';
import 'package:main_sociavism/models/user_model.dart';

class PostModel {
  final String id;
  final NgoModel creator;
  final String caption;
  final List<String> images;
  final List<UserModel> volunteers;
  final int volunteerLimit;
  final bool isEvent;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    required this.id,
    required this.caption,
    required this.images,
    required this.volunteers,
    required this.volunteerLimit,
    required this.isEvent,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
  });
}
