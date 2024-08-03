import 'ngo_model.dart';

class MissionModel {
  final String id;
  final NgoModel creator;
  final String creatorId;
  final String caption;
  final List images;
  final List volunteers;
  final int ngoLimit;
  final bool isEvent;
  final String createdAt;
  final String updatedAt;

  MissionModel({
    required this.id,
    required this.caption,
    required this.creatorId,
    required this.images,
    required this.volunteers,
    required this.ngoLimit,
    required this.isEvent,
    required this.creator,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'] ?? '',
      caption: json['caption'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      volunteers: List<String>.from(json['volunteers'] ?? []),
      ngoLimit: json['ngoLimit'] ?? 0,
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
      'ngoLimit': ngoLimit,
      'isEvent': isEvent,
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
    NgoModel? creator,
    String? creatorId,
    String? createdAt,
    String? updatedAt,
  }) {
    return MissionModel(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      images: images ?? this.images,
      volunteers: volunteers ?? this.volunteers,
      ngoLimit: ngoLimit ?? this.ngoLimit,
      isEvent: isEvent ?? this.isEvent,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
