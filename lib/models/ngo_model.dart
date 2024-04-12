class NgoModel {
  final String email;
  final String profilePhoto;
  final String name;
  final String about;
  final String location;
  final String phoneNo;
  final String socialLink;

  NgoModel({
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.about,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
  });

  NgoModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        profilePhoto = json['profilePhoto'],
        name = json['name'],
        about = json['about'],
        location = json['location'],
        phoneNo = json['phoneNo'],
        socialLink = json['socialLink'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'profilePhoto': profilePhoto,
        'name': name,
        'age': about,
        'location': location,
        'phoneNo': phoneNo,
        'socialLink': socialLink,
      };
}
