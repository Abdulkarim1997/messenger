import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/social_app/cubit/states.dart';
import 'package:messenger/shard/components/components.dart';
import 'package:messenger/shard/styles/icon_broken.dart';

import '../../modules/social_app/new_post/new_post_screen.dart';
import 'cubit/cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SocialNewPostState) {
          debugPrint("emmited");
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocailCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: "Users",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: "Setting",
              ),
            ],
          ),
        );
      },
    );
  }
}
