import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/models/task/task_model.dart';
import 'package:todo_app/screens/tab/home/dialogs/priority_select_dialog.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';
import 'package:intl/intl.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/utilities.dart';
import 'category_select_dialog.dart';

updateTaskDialog({
  required BuildContext context,
  required TaskModel task,
  required ValueChanged<TaskModel> taskModelChanged,
}) {
  TaskModel taskModel = task;

  final TextEditingController titleController =
  TextEditingController(text: taskModel.title);
  final TextEditingController descriptionController =
  TextEditingController(text: taskModel.description);

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  String category = "work";
  int priority = 1;

  final FocusNode focusNodeOne = FocusNode();
  final FocusNode focusNodeTwo = FocusNode();
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.w),
                      topRight: Radius.circular(16.w)),
                  color: AppColors.c_363636),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Task",
                    style: AppTextStyle.latoBold.copyWith(fontSize: 20.w),
                  ),
                  14.getH(),
                  TextField(
                    style: AppTextStyle.latoBold,
                    focusNode: focusNodeOne,
                    onChanged: (v) {
                      taskModel = taskModel.copyWith(title: v);
                    },
                    textInputAction: TextInputAction.next,
                    controller: titleController,
                    decoration: InputDecoration(

                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        hintText: "Enter task",
                        hintStyle: AppTextStyle.latoRegular
                            .copyWith(fontSize: 18.w, color: AppColors.c_AFAFAF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.transparent),
                            borderRadius: BorderRadius.circular(4.w)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.c_AFAFAF),
                            borderRadius: BorderRadius.circular(4.w))),
                  ),
                  14.getH(),
                  TextField(
                    style: AppTextStyle.latoBold,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    focusNode: focusNodeTwo,
                    onChanged: (v) {
                      taskModel = taskModel.copyWith(description: v);
                    },
                    controller: descriptionController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        fillColor: Colors.transparent,
                        labelStyle:
                        AppTextStyle.latoRegular.copyWith(fontSize: 18.w),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        hintText: "Enter Description",
                        hintStyle: AppTextStyle.latoRegular
                            .copyWith(fontSize: 18.w, color: AppColors.c_AFAFAF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.transparent),
                            borderRadius: BorderRadius.circular(4.w)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.c_AFAFAF),
                            borderRadius: BorderRadius.circular(4.w))),
                  ),
                  35.getH(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () async {
                            dateTime = await showDatePicker(
                                barrierColor: AppColors.c_363636,
                                barrierDismissible: false,
                                cancelText: "Cancel",
                                confirmText: "Select",
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                currentDate: DateTime.now());
                            if (dateTime != null) {
                              setState(() {
                                taskModel =
                                    taskModel.copyWith(deadline: dateTime);
                              });
                            }
                          },
                          icon: SvgPicture.asset(AppImages.calendar, height: 24.h,)),
                      IconButton(
                          onPressed: () async {
                            timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 8, minute: 00),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child!,
                                );
                              },
                            );
                            if (timeOfDay != null) {
                              DateTime d = taskModel.deadline;
                              d.copyWith(
                                  hour: timeOfDay!.hour,
                                  minute: timeOfDay!.minute);
                              setState(() {
                                taskModel = taskModel.copyWith(deadline: d);
                              });
                            }
                          },
                          icon: SvgPicture.asset(AppImages.clock, height: 24.h)),

                      IconButton(
                          onPressed: () async {
                            showCategorySelectDialog(context: context, categorySelection: (selectedCategory) {
                              setState((){
                                category = selectedCategory;
                              });
                              taskModel = taskModel.copyWith(category: selectedCategory) ;

                            }, category: category);
                          },
                          icon: SvgPicture.asset(AppImages.tag, height: 24.h)),
                      IconButton(
                          onPressed: () {
                            showPrioritySelectDialog(
                                p: taskModel.priority,
                                context: context,
                                priority: (p) {
                                  setState(() {
                                    priority = p;
                                  });
                                  taskModel = taskModel.copyWith(priority: p);



                                });
                          },
                          icon: SvgPicture.asset(AppImages.flag, height: 24.h)),
                      IconButton(
                          onPressed: () {
                            if (taskModel.canAddTaskToDatabase()){
                              print(taskModel.title);
                              showSuccessMessage("SUCCESS");
                              taskModelChanged.call(taskModel);
                              Navigator.pop(context);
                            }
                            else {
                              showErrorMessage("ERROR");
                            }
                          },
                          icon: SvgPicture.asset(AppImages.next, height: 24.h)),
                    ],
                  ),


                ],
              ),
            ),
          );
        });
      });
}
