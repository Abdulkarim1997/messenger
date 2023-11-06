import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/social_app/cubit/cubit.dart';
import 'package:messenger/layout/social_app/cubit/states.dart';
import 'package:messenger/shard/components/components.dart';
import 'package:messenger/shard/styles/icon_broken.dart';

import '../../../models/social_app/social_user_model.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SocialUserModel? userModel = SocailCubit.get(context).userModel;
        File? profileImage = SocailCubit.get(context).profileImage;
        File? coverImage = SocailCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Edit Profile", actions: [
            defaultTextButton(
                function: () {
                  SocailCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: phoneController.text);
                },
                text: "update"),
            const SizedBox(
              width: 15,
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialUserUpdateLoadingState)
                  const SizedBox(
                    height: 10.0,
                  ),
                SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(
                                            "${userModel.cover}",
                                          )
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocailCubit.get(context).getCoverImage();
                              },
                              icon: const CircleAvatar(
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                                radius: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              backgroundImage: profileImage == null
                                  ? NetworkImage("${userModel.image}")
                                  : FileImage(profileImage) as ImageProvider,
                              radius: 60,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              SocailCubit.get(context).getProfileImage();
                            },
                            icon: const CircleAvatar(
                              child: Icon(
                                IconBroken.Camera,
                                size: 16.0,
                              ),
                              radius: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (SocailCubit.get(context).profileImage != null ||
                    SocailCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (SocailCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocailCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: "upload profile"),
                              if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      if (SocailCubit.get(context).profileImage != null &&
                          SocailCubit.get(context).coverImage != null)
                        const SizedBox(
                          width: 5.0,
                        ),
                      if (SocailCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: () {
                                    SocailCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  text: "upload cover"),
                              if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                if (SocailCubit.get(context).profileImage != null ||
                    SocailCubit.get(context).coverImage != null)
                  const SizedBox(
                    height: 20.0,
                  ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "name must not be empty";
                      }
                      return null;
                    },
                    lable: "Name",
                    prefix: IconBroken.User),
                const SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "bio must not be empty";
                      }
                      return null;
                    },
                    lable: "Bio",
                    prefix: IconBroken.Info_Circle),
                const SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "phone must not be empty";
                      }
                      return null;
                    },
                    lable: "phone",
                    prefix: IconBroken.Call),
              ],
            ),
          ),
        );
      },
    );
  }
}
