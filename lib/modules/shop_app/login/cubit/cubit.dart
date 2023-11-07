import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/shop_app/login/cubit/states.dart';
import 'package:messenger/shard/network/end_points.dart';
import 'package:messenger/shard/network/rmote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginstates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  ShopLoginModel? loginModel;
  ShopLoginCubit() : super(ShopLoginInitalState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(path: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) async {
      print("statelogin?" +
          value.data.toString()); // this object from data Recive
      loginModel = ShopLoginModel.fromJson(value.data);
      print("jojo ${loginModel?.status}loginModel.status");
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print('error: ' + error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    print('and' + isPassword.toString());
    emit(ShopChangePasswordVisibilityState());
  }
}
