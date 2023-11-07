import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/shop_app/register/cubit/states.dart';
import 'package:messenger/shard/network/end_points.dart';
import 'package:messenger/shard/network/rmote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterstates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  ShopLoginModel? loginModel;
  ShopRegisterCubit() : super(ShopRegisterInitalState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(path: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) async {
      print("statelogin?" +
          value.data.toString()); // this object from data Recive
      loginModel = ShopLoginModel.fromJson(value.data);
      print("jojo ${loginModel?.status}loginModel.status");
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      print('error: ' + error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    print('and' + isPassword.toString());
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
