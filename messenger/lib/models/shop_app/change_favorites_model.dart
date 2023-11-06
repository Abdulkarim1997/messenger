class ChangeFavoritesModel {
  final bool? status;
  final String? message;

  ChangeFavoritesModel._({this.status, this.message});
  factory ChangeFavoritesModel.fromJson(Map<String, dynamic> json) =>
      ChangeFavoritesModel._(status: json['status'], message: json['message']);
}
