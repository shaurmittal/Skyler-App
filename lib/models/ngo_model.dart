class NgoModel {
  final String id;
  final String email;
  final String profilePhoto;
  final String name;
  final String about;
  final String location;
  final String phoneNo;
  final String socialLink;
  final String createdAt;
  final String updatedAt;

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

  NgoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        profilePhoto = json['profilePhoto'],
        name = json['name'],
        about = json['about'],
        location = json['location'],
        phoneNo = json['phoneNo'],
        socialLink = json['socialLink'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
