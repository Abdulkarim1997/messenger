class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool isEmailVerified;
  SocialUserModel({
    required this.name,
    required this.phone,
    required this.uId,
    required this.email,
    required this.isEmailVerified,
    this.image,
    this.cover,
    required this.bio,
  });

  factory SocialUserModel.fromJson(Map<String, dynamic> json) =>
      SocialUserModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        uId: json["uId"],
        isEmailVerified: json["isEmailVerified"],
        image: json["image"],
        cover: json["cover"],
        bio: json["bio"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'bio': bio,
    };
  }
}
