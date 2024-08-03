class NgoModel {
  final String id;
  final String email;
  final String profilePhoto;
  final String name;
  final String about;
  final String location;
  final String phoneNo;
  final String socialLink;
  String? createdAt;
  final String updatedAt;
  int? gems;

  NgoModel({
    required this.id,
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.about,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
    this.createdAt,
    required this.updatedAt,
     this.gems,
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
        gems = json['gems'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'profilePhoto': profilePhoto,
      'name': name,
      'about': about,
      'location': location,
      'phoneNo': phoneNo,
      'socialLink': socialLink,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'gems': gems,
    };
  }
}
