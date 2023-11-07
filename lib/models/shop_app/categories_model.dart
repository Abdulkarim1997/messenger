class CategoriesModel {
  final bool? status;
  final CategoriesDataModel? data;

  CategoriesModel._({
    required this.status,
    required this.data,
  });
  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel._(
          status: json['status'],
          data: CategoriesDataModel.fromJson(json['data']));
}

class CategoriesDataModel {
  final int? CurrentPage;
  final List<DataModel>? data;
  CategoriesDataModel._({required this.CurrentPage, required this.data});
  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) =>
      CategoriesDataModel._(
        CurrentPage: json['current_page'],
        data: List<DataModel>.from(
            json['data'].map((data) => DataModel.fromJson(data))),
      );
}

class DataModel {
  final int? id;
  final String? name;
  final String? image;
  DataModel._({this.name, this.image, this.id});
  factory DataModel.fromJson(Map<String, dynamic> json) =>
      DataModel._(id: json['id'], name: json['name'], image: json['image']);
}
