class UserModel {
  final String email;
  final String profilePhoto;
  final String name;
  final String age;
  final String location;
  final String phoneNo;
  final String socialLink;

  UserModel({
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.age,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        profilePhoto = json['profilePhoto'],
        name = json['name'],
        age = json['age'],
        location = json['location'],
        phoneNo = json['phoneNo'],
        socialLink = json['socialLink'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'profilePhoto': profilePhoto,
        'name': name,
        'age': age,
        'location': location,
        'phoneNo': phoneNo,
        'socialLink': socialLink,
      };
}
