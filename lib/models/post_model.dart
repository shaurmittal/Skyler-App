import 'package:main_sociavism/models/ngo_model.dart';

class PostModel {
  final String id;
  final NgoModel creator;
  final String creatorId;
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
    required this.creatorId,
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
      creatorId: json['creatorId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'images': images,
      'volunteers': volunteers,
      'volunteerLimit': volunteerLimit,
      'isEvent': isEvent,
      'creator': creator.toJson(),
      'creatorId': creatorId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  PostModel copyWith({
    String? id,
    String? caption,
    List? images,
    List? volunteers,
    int? volunteerLimit,
    bool? isEvent,
    NgoModel? creator,
    String? creatorId,
    String? createdAt,
    String? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      images: images ?? this.images,
      volunteers: volunteers ?? this.volunteers,
      volunteerLimit: volunteerLimit ?? this.volunteerLimit,
      isEvent: isEvent ?? this.isEvent,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
