import 'package:findmyngo/models/ngo_model.dart';

class MissionModel {
  final String id;
  final NgoModel creator;
  final String creatorId;
  final String caption;
  final List images;
  final List ngoVolunteers;
  final List ngoVolunteersId;
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
    required this.ngoVolunteersId,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      ngoVolunteers: List<String>.from(json['ngoVolunteers'] ?? []),
      ngoLimit: json['ngoLimit'] ?? 0,
      creator: json['creator'] ?? '',
      creatorId: json['creatorId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      ngoVolunteersId: List<String>.from(json['ngoVolunteersId'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caption': caption,
      'images': images,
      'ngoVolunteers': ngoVolunteers,
      'ngoLimit': ngoLimit,
      'creator': creator.toJson(),
      'creatorId': creatorId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'ngoVolunteersId': ngoVolunteersId,
    };
  }

  MissionModel copyWith({
    String? id,
    String? caption,
    List? images,
    List? ngoVolunteers,
    int? ngoLimit,
    bool? isEvent,
    NgoModel? creator,
    String? creatorId,
    String? createdAt,
    String? updatedAt,
    List? ngoVolunteersId,
  }) {
    return MissionModel(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      images: images ?? this.images,
      ngoVolunteers: ngoVolunteers ?? this.ngoVolunteers,
      ngoLimit: ngoLimit ?? this.ngoLimit,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ngoVolunteersId: ngoVolunteersId ?? this.ngoVolunteersId,
    );
  }
}
