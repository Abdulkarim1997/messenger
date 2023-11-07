import '../../../../models/shop_app/login_model.dart';

abstract class ShopLoginstates{

}

class ShopLoginInitalState extends ShopLoginstates{}
class ShopLoginLoadingState extends ShopLoginstates{}
class ShopLoginSuccessState extends ShopLoginstates{
    final ShopLoginModel loginModel;
    ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginstates{
  final String  error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginstates{}