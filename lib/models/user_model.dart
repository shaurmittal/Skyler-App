class UserModel {
  final String id;
  final String email;
  final String profilePhoto;
  final String name;
  final String age;
  final String location;
  final String phoneNo;
  final String socialLink;
  String? createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.profilePhoto,
    required this.name,
    required this.age,
    required this.location,
    required this.phoneNo,
    required this.socialLink,
    this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? '',
      location: json['location'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      socialLink: json['socialLink'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'profilePhoto': profilePhoto,
      'name': name,
      'age': age,
      'location': location,
      'phoneNo': phoneNo,
      'socialLink': socialLink,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
