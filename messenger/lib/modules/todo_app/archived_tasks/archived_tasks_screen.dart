import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shard/components/components.dart';
import '../../../shard/cubit/cubit.dart';
import '../../../shard/cubit/states.dart';



class ArchivedTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit,AppSates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context,  state) {
        var tasks = Appcubit.get(context).archiveTasks;
        return tasksBuilder(tasks);
      },
    );
  }
}
