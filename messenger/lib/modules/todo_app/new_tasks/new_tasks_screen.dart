import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/shard/cubit/cubit.dart';
import 'package:messenger/shard/cubit/states.dart';

import '../../../shard/components/components.dart';



class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, AppSates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = Appcubit.get(context).newTasks;
        return tasksBuilder(tasks);
      },
    );
  }
}
