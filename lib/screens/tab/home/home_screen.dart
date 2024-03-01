import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/local/local_database.dart';
import 'package:todo_app/models/task/task_model.dart';
import 'package:todo_app/screens/tab/home/dialogs/add_task_dialog.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/extensions/my_extensions.dart';

import 'dialogs/update_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> tasks = [];

  _init() async {
    tasks = await LocalDatabase.getAllTasks();
    setState(() {});

  }
  _searchQuery(String q) async {
    tasks = await LocalDatabase.searchTasks(q);
    setState(() {});
  }

  TaskModel taskModel = TaskModel.initialValue;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.more),
        ),
        title: Text(
          "Index",
          style: AppTextStyle.latoRegular.copyWith(fontSize: 20.w),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Image.asset(
              AppImages.profileOne,
            ),
          )
        ],
      ),
      body: tasks.isEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  75.getH(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 74.w),
                    child: Image.asset(AppImages.homeImage),
                  ),
                  49.getH(),
                  Text(
                    "What do you want to do today?",
                    style: AppTextStyle.latoRegular.copyWith(fontSize: 20.w),
                  ),
                  10.getH(),
                  Text(
                    "Tap + to add your tasks",
                    style: AppTextStyle.latoRegular.copyWith(fontSize: 16.w),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
            color: AppColors.white,
            backgroundColor: Colors.blue,
            onRefresh: (){_init();
              return Future <void>.delayed(Duration(seconds: 2));},
            child: ListView(
                children:
                [Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TextField(

                    style: AppTextStyle.latoBold,
                    onChanged: _searchQuery,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(

                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search, color: AppColors.c_AFAFAF,),
                        hintStyle: AppTextStyle.latoRegular
                            .copyWith(fontSize: 18.w, color: AppColors.c_AFAFAF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.c_AFAFAF),
                            borderRadius: BorderRadius.circular(4.w)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.c_AFAFAF),
                            borderRadius: BorderRadius.circular(4.w))),
                  ),
                ),
                  10.getH(),
                  ...List.generate(tasks.length, (index) {
                  TaskModel taskModel = tasks[index];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: AppColors.c_363636),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              taskModel.title,
                              style: AppTextStyle.latoBold,
                            ),
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.c_8687E7),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.flag),
                                  5.getW(),
                                  Text(
                                    taskModel.priority.toString(),
                                    style: AppTextStyle.latoBold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        8.getH(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${taskModel.deadline.year.toString()}-${taskModel.deadline.month.toString().padLeft(2, '0')}-${taskModel.deadline.day.toString().padLeft(2, '0')} ${taskModel.deadline.hour.toString().padLeft(2, '0')}-${taskModel.deadline.minute.toString().padLeft(2, '0')}",
                              style: AppTextStyle.latoBold
                                  .copyWith(color: AppColors.c_AFAFAF),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  updateTaskDialog(
                                    context: context,
                                    task: taskModel,
                                    taskModelChanged: (updatedTask) async {
                                      await LocalDatabase.updateTask(
                                        updatedTask.copyWith(id: taskModel.id),
                                        taskModel.id!,
                                      );
                                      _init();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                            IconButton(
                                onPressed: () async {
                                  int d = await LocalDatabase.deleteTask(
                                      taskModel.id!);
                                  print("DELETED ID:$d");
                                  _init();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ],
                    ),
                  );
                })],
              ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskDialog(
            context: context,
            taskModelChanged: (task) async {
              print(taskModel.title);
              await LocalDatabase.insertTask(task);
              _init();
            },
          );
        },
        backgroundColor: AppColors.c_8687E7,
        child: Icon(
          Icons.add,
          size: 32.h,
        ),
      ),
    );
  }
}
