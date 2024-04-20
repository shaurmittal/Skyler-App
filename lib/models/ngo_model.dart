class NgoModel {
  final String id;
  final String email;
  final String profilePhoto;
  final String name;
  final String about;
  final String location;
  final String phoneNo;
  final String socialLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  NgoModel({
    required this.id,
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.about,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
    required this.createdAt,
    required this.updatedAt,
  });
}
