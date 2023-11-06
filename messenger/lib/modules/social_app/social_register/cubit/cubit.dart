import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/social_app/social_user_model.dart';
import 'package:messenger/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  SocialRegisterCubit() : super(SocialRegisterInitalState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.uid.toString());
      print(value.user?.email.toString());
      userCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image:
          "https://img.freepik.com/free-photo/close-up-confident-male-employee-white-collar-shirt-smiling-camera-standing-self-assured-against-studio-background_1258-26761.jpg?w=740&t=st=1679054475~exp=1679055075~hmac=02d815efd9bd58f86182ca93e17845f54280367f60ec02346378b62bbd765040",
      cover:
          "https://img.freepik.com/free-vector/nature-forest-landscape-background_1308-69513.jpg?w=826&t=st=1679054176~exp=1679054776~hmac=f747880dbddfad19a44ea12beff6763d31cb294d38f465b0d8c19a1270b12d59",
      bio: "Write bio here ...",
    );
    print("wq22 ${model.toMap()}");
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    print('and' + isPassword.toString());
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
