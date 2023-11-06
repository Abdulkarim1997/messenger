import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/shop_app/cubit/cubit.dart';
import 'package:messenger/shard/components/constants.dart';

import '../../../layout/shop_app/cubit/states.dart';
import '../../../shard/components/components.dart';
import '../../../shard/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if (state is ShopSuccessUserDataState) {
        //   print("vvvaa ${nameController.text}");
        //   nameController.text = state.userModel.data!.name!;
        //   emailController.text = state.userModel.data!.email!;
        //   phoneController.text = state.userModel.data!.phone!;
        // }
      },
      builder: (context, state) {
        if (state is ShopSuccessUpdateUserState) {
          showToast(
              text: "The profile has been updated", state: ToastStates.SUCCESS);
        }
        var model = ShopCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel?.status != null &&
              ShopCubit.get(context).userModel?.status != false,
          builder: (context) {
            print('llla ${model?.status}');

            nameController.text = model?.data?.name ?? 'no name ';
            emailController.text = model?.data?.email ?? 'no email ';
            phoneController.text = model?.data?.phone ?? 'no phone ';
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      lable: 'Name',
                      validator: (String? value) {
                        if (value!.isEmpty) return 'name must not be empty';

                        return null;
                      },
                      prefix: Icons.person_outline,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      lable: 'Email Address',
                      validator: (String? value) {
                        if (value!.isEmpty) return 'email must not be empty';

                        return null;
                      },
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      lable: 'Phone',
                      validator: (String? value) {
                        if (value!.isEmpty) return 'phone must not be empty';

                        return null;
                      },
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        background: defaultColor,
                        function: () {
                          signOut(context);
                        },
                        text: 'LOGOUT'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        background: defaultColor,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'UPDATE'),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
