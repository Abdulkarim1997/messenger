import '../../../../models/shop_app/login_model.dart';

abstract class ShopRegisterstates {}

class ShopRegisterInitalState extends ShopRegisterstates {}

class ShopRegisterLoadingState extends ShopRegisterstates {}

class ShopRegisterSuccessState extends ShopRegisterstates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterstates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterstates {}
