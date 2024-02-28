import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/tab/home/dialogs/add_task_dialog.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TaskModel taskModel=TaskModel.initialValue;
  DateTime? dateTime;
  TimeOfDay? timeOfDay;

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
      body: SingleChildScrollView(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskDialog(
              context: context,
              taskModel: (task) {
                taskModel = task;
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
