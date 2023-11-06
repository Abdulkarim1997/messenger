class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  PostModel({
    required this.name,
    required this.uId,
    this.image,
    required this.dateTime,
    this.text,
    this.postImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json["name"],
        uId: json["uId"],
        image: json["image"],
        dateTime: json["dateTime"],
        text: json["text"],
        postImage: json["postImage"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
