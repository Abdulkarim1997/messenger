import 'package:messenger/models/shop_app/login_model.dart';

import '../../../models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel? userModel;
  ShopSuccessUserDataState(this.userModel);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel? userModel;
  ShopSuccessUpdateUserState(this.userModel);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {}
