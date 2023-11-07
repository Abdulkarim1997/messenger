import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layout/news_app/cubit/cubit.dart';
import 'package:messenger/shard/components/components.dart';

import '../../../layout/news_app/cubit/states.dart';


class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, State) {},
      builder: (context, State) {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list);
      },
    );
  }
}
