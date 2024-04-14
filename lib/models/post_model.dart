class PostModel {
  final String profilePhoto;
  final String name;
  final String postDate;
  final String caption;
  final List<String> images;
  final List<String> volunteerId;
  final int volunteerLimit;
  final bool isEvent;
  final String createdAt;
  final String updatedAt;

  PostModel({
    required this.profilePhoto,
    required this.name,
    required this.postDate,
    required this.caption,
    required this.images,
    required this.volunteerId,
    required this.volunteerLimit,
    required this.isEvent,
    required this.createdAt,
    required this.updatedAt,
  });
}
