class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  // ShopLoginModel({this.status, this.message, this.data});
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    // ShopLoginModel(
    //     status: json['status'],
    //     message: json['message'] ?? "",
    //     data: (json['data'] != null ? UserData.fromJson(json['data']) : null));
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? points;
  int? credit;
  String? token;
  // constructor
  // UserData._({
  //   required this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.credit,
  //   required this.token,
  //   this.points,
  // });
  //  named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    // UserData._(
    //   name: json['name'],
    //   token: json['token'],
    //   id: json['id'],
    //   email: json['email'],
    //   phone: json['phone'],
    //   credit: json['credit'],
    //   points: json['points'],
    // );
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    credit = json['credit'];
    token = json['token'];
    points = json['points'];
  }
}
