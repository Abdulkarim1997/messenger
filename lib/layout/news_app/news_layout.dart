import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/news_app/cubit/cubit.dart';
import 'package:messenger/layout/news_app/cubit/states.dart';
import 'package:messenger/shard/components/components.dart';
import 'package:messenger/shard/cubit/cubit.dart';

import '../../modules/news_app/search/search_secreen.dart';



class  NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,State){},
      builder: (context,State){
        var cubit = NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            "NewsApp",
          ),
          actions: [
            IconButton(
              onPressed:(){
                navigateTo(context,SearchSecreen() );
              },
              icon: const Icon(Icons.search)
             ),
            IconButton(
              onPressed:(){
                Appcubit.get(context).changeAppMode(); 
              },
              icon: const Icon(Icons.brightness_4_outlined)
             ),
          ],
        ),
      
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar:BottomNavigationBar(
          items:cubit.bottomItem ,
          currentIndex: cubit.currentIndex,
          onTap: (index){
            cubit.changeBottomNavBar(index);
          },
        ),
      );
      },
    );
  }
}
