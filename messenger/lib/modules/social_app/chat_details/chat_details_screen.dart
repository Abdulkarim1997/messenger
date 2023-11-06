import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/social_app/message_model.dart';
import 'package:messenger/models/social_app/social_user_model.dart';
import 'package:messenger/shard/styles/colors.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shard/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;
  TextEditingController messageController = TextEditingController();
  ChatDetailsScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocailCubit.get(context).getMessages(reciverId: userModel.uId);
        return BlocConsumer<SocailCubit, SocialStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userModel.image!),
                      radius: 20.0,
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(userModel.name!),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocailCubit.get(context).messages.isNotEmpty,
                builder: (BuildContext context) {
                  print("one");
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var message =
                                  SocailCubit.get(context).messages[index];
                              if (SocailCubit.get(context).userModel?.uId ==
                                  message.senderId) {
                                return buidMyMessage(message);
                              }
                              return buidMessage(message);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 15.0,
                              );
                            },
                            itemCount: SocailCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: grey300Color!,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: defaultColor,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    SocailCubit.get(context).sendMessage(
                                        reciverId: userModel.uId,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text);
                                    messageController.clear();
                                  },
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) {
                  print("two");
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buidMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Text(message.text!),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
        ),
      );
  Widget buidMyMessage(MessageModel message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          child: Text(message.text!),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.3),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
        ),
      );
}
