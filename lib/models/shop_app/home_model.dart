class HomeModel {
  final bool? status;
  final HomeDataModel? data;

  HomeModel._({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel._(
      status: json['status'], data: HomeDataModel.fromJson(json['data']));
}

class HomeDataModel {
  // Note Here Do not put late replaced with  nullable
  final List<BannerModel>? banners;
  final List<ProductModel>? products;

  HomeDataModel._({
    required this.banners,
    required this.products,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel._(
      banners: List<BannerModel>.from(
          json['banners'].map((banner) => BannerModel.fromJson(banner))),
      products: List<ProductModel>.from(
          json['products'].map((product) => ProductModel.fromJson(product))),
    );
  }
}

class BannerModel {
  int? id;
  String? image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
