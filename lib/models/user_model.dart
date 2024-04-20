class UserModel {
  final String id;
  final String email;
  final String profilePhoto;
  final String name;
  final String age;
  final String location;
  final String phoneNo;
  final String socialLink;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.age,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
    required this.createdAt,
    required this.updatedAt,
  });
}
