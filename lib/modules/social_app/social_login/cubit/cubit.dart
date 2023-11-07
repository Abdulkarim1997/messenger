import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/modules/social_app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  SocialLoginCubit() : super(SocialLoginInitalState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.uid);
      print(value.user?.email);
      emit(SocialLoginSuccessState(value.user!.uid.toString()));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    print('and' + isPassword.toString());
    emit(SocialChangePasswordVisibilityState());
  }
}
