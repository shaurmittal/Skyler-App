import 'package:main_sociavism/models/ngo_model.dart';
import 'package:main_sociavism/models/user_model.dart';

class PostModel {
  final String id;
  final NgoModel creator;
  final String caption;
  final List images;
  final List volunteers;
  final int volunteerLimit;
  final bool isEvent;
  final String createdAt;
  final String updatedAt;

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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      volunteers: List<String>.from(json['volunteers'] ?? []),
      volunteerLimit: json['volunteerLimit'] ?? 0,
      isEvent: json['isEvent'] ?? false,
      creator: json['creator'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
