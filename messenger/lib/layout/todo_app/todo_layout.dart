import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shard/components/components.dart';
import '../../shard/cubit/cubit.dart';
import '../../shard/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();



  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => Appcubit()..createDatabase(),
        child: BlocConsumer<Appcubit,AppSates>(
            listener: (context, state) {
              if(state is AppInsertDatabaseState){
                Navigator.pop(context);
              }
            },
            builder: (context,state) {
              Appcubit cubit = Appcubit.get(context);
              return
                Scaffold(
                  key: scaffoldKey,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: AppBar(
                      title: Text(
                        cubit.titles[cubit.currentIndex],
                      ),
                    ),
                  ),
                  body: ConditionalBuilder(
                    condition: state is! AppGetDatabaseLoadingState ,
                    builder: (context) => cubit.screens[cubit.currentIndex],
                    fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      if (cubit.isBottomSheetShow) {
                        if (formKey.currentState!.validate()) {
                          cubit.insertDatabase(
                              title: titleController.text,
                              time:timeController.text
                              , date:dateController.text
                          );
                          // insertDatabase(
                          //   title: titleController.text,
                          //   time: timeController.text,
                          //   date: dateController.text,
                          // ).then((value) {
                          //   getDataFromDatabase(database).then((value) {
                          //     Navigator.pop(context);
                          //     // setState(() {
                          //     //
                          //     //   isBottomSheetShow = false;
                          //     //   fabIcon = Icons.edit;
                          //     //   tasks = value;
                          //     // });
                          //     print(tasks);
                          //   });
                          // });
                        }
                      } else {
                        scaffoldKey.currentState
                            ?.showBottomSheet(

                              (context) =>
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                        controller: titleController,
                                        type: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ('title must\'nt be empty');
                                          }
                                          return null;
                                        },
                                        lable: 'Task Title',
                                        prefix: Icons.title,
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultFormField(
                                        isClickable: true,
                                        controller: timeController,
                                        type: TextInputType.datetime,
                                        onTap: () {
                                          showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timeController.text =
                                                value!.format(context)
                                                    .toString();
                                            print(value.format(context)
                                                .toString());
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ('time must\'nt be empty');
                                          }
                                          return null;
                                        },
                                        lable: 'Task Time',
                                        prefix: Icons.watch_later_outlined,
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultFormField(
                                        isClickable: true,
                                        controller: dateController,
                                        type: TextInputType.datetime,
                                        onTap: () {
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.parse(
                                                  '2023-01-01'))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd().format(
                                                    value!);
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ('date must\'nt be empty');
                                          }
                                          return null;
                                        },
                                        lable: 'date Time',
                                        prefix: Icons.calendar_today,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 20.0,
                        )
                            .closed
                            .then((value) {
                              cubit.changeBottomSheetState(isShow: false, icon: Icons.edit );

                        });
                        cubit.changeBottomSheetState(isShow: true, icon: Icons.add );
                      }
                    },
                    child: Icon(
                      cubit.fabIcon ,
                    ),
                  ),
                  bottomNavigationBar: BottomNavigationBar(

                    type: BottomNavigationBarType.fixed,
                    // backgroundColor: Colors.red,
                    // elevation: 50.0,
                    // showSelectedLabels: false,
                    currentIndex:  cubit.currentIndex ,
                    onTap: (index) {
                      // setState(() {
                     cubit.changeIndex(index);
                      // });
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.task_outlined,
                        ),
                        label: 'Task',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.check_circle_outline,
                        ),
                        label: 'Done',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.archive_outlined,
                        ),
                        label: 'Archived',
                      ),
                    ],
                  ),
                );
            }
        )
    );




  }
}

