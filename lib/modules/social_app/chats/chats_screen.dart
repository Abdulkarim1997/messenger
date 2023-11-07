import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/social_app/cubit/cubit.dart';
import 'package:messenger/layout/social_app/cubit/states.dart';
import 'package:messenger/models/social_app/social_user_model.dart';
import 'package:messenger/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:messenger/shard/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocailCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(context, SocailCubit.get(context).users[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocailCubit.get(context).users.length),
          fallback: (context) =>
              Center(child: const CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(context, SocialUserModel model) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetailsScreen(
                userModel: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  model.image!,
                ),
                radius: 25,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                model.name!,
                style: TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
