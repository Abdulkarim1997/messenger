import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/news_app/cubit/cubit.dart';
import 'package:messenger/layout/news_app/cubit/states.dart';
import 'package:messenger/shard/components/components.dart';

class SearchSecreen extends StatelessWidget {

var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context, state) {} ,

     builder: (context,state){
      var list=NewsCubit.get(context).search;
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                controller: searchController,
                 type:TextInputType.text ,
                 onChanged: (value){
                  NewsCubit.get(context).getSearch(value);
                 },
                  validator: (value){
                    if(value == null){
                          return 'search must not be empty';
                    }
                    return null;  
                  },
                   lable:'Search' ,
                    prefix:Icons.search ,
                    ),
            ),
            Expanded(
              child: articleBuilder(list,isSearch: true),
              ),
          ],
        ),
      );
     },     
    );
  }
}