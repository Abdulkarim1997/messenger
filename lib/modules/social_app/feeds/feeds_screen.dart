import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/models/social_app/post_model.dart';
import 'package:messenger/shard/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/states.dart';
import '../../../shard/styles/colors.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocailCubit.get(context).posts.isNotEmpty &&
              SocailCubit.get(context).userModel != null,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        const Image(
                          image: NetworkImage(
                            "https://img.freepik.com/premium-psd/young-adult-wearing-forest-apparel-tshirt_23-2149292867.jpg?w=740",
                          ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 225.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "communicate with friends",
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: whiteColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        buildPostItem(SocailCubit.get(context).posts[index],
                            context, index),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 8,
                    ),
                    itemCount: SocailCubit.get(context).posts.length,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            );
          },
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, BuildContext context, int index) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name!,
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          model.dateTime!,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                    width: double.infinity, height: 1.0, color: grey300Color),
              ),
              Text(
                model.text!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Container(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 0,
                  top: 5,
                ),
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          textColor: defaultColor,
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          height: 20,
                          onPressed: () {},
                          child: Text("#Software"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          textColor: defaultColor,
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          height: 20,
                          onPressed: () {},
                          child: Text("#Software"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          textColor: defaultColor,
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          height: 20,
                          onPressed: () {},
                          child: Text("#Flutter"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != "")
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5.0,
                  ),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                          image: NetworkImage(
                            model.postImage!,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocailCubit.get(context).likePost(
                              SocailCubit.get(context)
                                  .postId[index]
                                  .toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                color: redColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocailCubit.get(context).likes[index]}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                color: amberColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${SocailCubit.get(context).comments[index]}",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Container(
                    width: double.infinity, height: 1.0, color: grey300Color),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocailCubit.get(context).commentPost(
                            SocailCubit.get(context).postId[index],
                            "this is a comment");
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                SocailCubit.get(context).userModel!.image!),
                            radius: 18,
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Write a comment ...",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: redColor,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Like",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          color: redColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Share",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
