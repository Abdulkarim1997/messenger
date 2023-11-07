import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/shop_app/cubit/states.dart';
import 'package:messenger/models/shop_app/favorites_model.dart';
import 'package:messenger/models/shop_app/home_model.dart';
import 'package:messenger/shard/network/end_points.dart';
import 'package:messenger/shard/network/rmote/dio_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../modules/shop_app/cateogries/cateogries_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shard/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CateogriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    print("token: $token");
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token: token ?? '',
    ).then((value) {
      print('object');
      if (value?.statusCode == 200) print('Dio with statusCode 200');
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print("Error:" + error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    print("token: $token");

    DioHelper.getData(
      path: GET_CATEGORIES,
      token: token ?? '',
    ).then((value) {
      print('object');
      if (value?.statusCode == 200) print('Dio with statusCode 200');
      categoriesModel = CategoriesModel.fromJson(value?.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print("Error:" + error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    print("token: $token");
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      path: FAVORITES,
      token: token ?? '',
    ).then((value) {
      print('object');
      if (value?.statusCode == 200) print('Dio with statusCode 200');
      favoritesModel = FavoritesModel.fromJson(value?.data);
      printFullText(value?.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print("Error:" + error.toString());
      emit(ShopSuccessGetFavoritesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      path: FAVORITES,
      data: {'product_id': productId},
      token: token ?? '',
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print("sss" + changeFavoritesModel!.status!.toString());
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    print("token: $token");
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      path: PROFILE,
      token: token ?? '',
    ).then((value) async {
      print('object33');
      if (value?.statusCode == 200) print('Dio with statusCode 200');
      print(value?.data ?? 'lllld');
      userModel = ShopLoginModel.fromJson(value?.data);

      printFullText(userModel?.data?.name ?? 'no name ');
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print("Error:" + error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    print("token: $token");
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      data: {
        "name": name,
        "email": email,
        "phone": phone,
      },
      path: UPDATE_PROFILE,
      token: token ?? '',
    ).then((value) async {
      print('object33');
      if (value?.statusCode == 200) print('Dio with statusCode 200');
      print(value?.data ?? 'lllld');
      userModel = ShopLoginModel.fromJson(value?.data);

      printFullText(userModel?.data?.name ?? 'no name ');
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print("Error:" + error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
