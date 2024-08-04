import 'package:findmyngo/models/user_model.dart';

class MissionModel {
  final String id;
  final UserModel creator;
  final String creatorId;
  final String caption;
  final List images;
  final List ngoVolunteers;
  final int ngoLimit;
  final String createdAt;
  final String updatedAt;

  MissionModel({
    required this.id,
    required this.caption,
    required this.creatorId,
    required this.images,
    required this.ngoVolunteers,
    required this.ngoLimit,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      ngoVolunteers: List<String>.from(json['volunteers'] ?? []),
      ngoLimit: json['ngoLimit'] ?? 0,
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
      'volunteers': ngoVolunteers,
      'ngoLimit': ngoLimit,
      'creator': creator.toJson(),
      'creatorId': creatorId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  MissionModel copyWith({
    String? id,
    String? caption,
    List? images,
    List? volunteers,
    int? ngoLimit,
    bool? isEvent,
    UserModel? creator,
    String? creatorId,
    String? createdAt,
    String? updatedAt,
  }) {
    return MissionModel(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      images: images ?? this.images,
      ngoVolunteers: volunteers ?? this.ngoVolunteers,
      ngoLimit: ngoLimit ?? this.ngoLimit,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
