import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/social_app/cubit/cubit.dart';
import 'package:messenger/shard/components/components.dart';
import 'package:messenger/shard/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Create Post", actions: [
            defaultTextButton(
                function: () {
                  DateTime now = DateTime.now();
                  if (SocailCubit.get(context).postImage == null) {
                    SocailCubit.get(context).createPost(
                        dateTime: now.toString(), text: textController.text);
                  } else {
                    SocailCubit.get(context).uploadPostImage(
                        dateTime: now.toString(), text: textController.text);
                  }
                },
                text: "Post")
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 5,
                  ),
                Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=740&t=st=1678608618~exp=1678609218~hmac=a6b4a6e7ea21d399b9b027ccc528921232645a3c7dd2b7976c6ead20a6c803a4"),
                      radius: 25,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        "Abdulkaim Salem",
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: "what is in your mind ...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if ((SocailCubit.get(context).postImage != null))
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                              image: FileImage(
                                  SocailCubit.get(context).postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocailCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                          radius: 20.0,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocailCubit.get(context).getpostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("add photo"),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("# tags"),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
