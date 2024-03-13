import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/tab/home/dialogs/update_task_dialog.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/local/local_database.dart';
import '../../../models/task/task_model.dart';
import '../../../utils/images/app_images.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<TaskModel> tasks = [];
  List<TaskModel> selectTasks = [];

  _init() async {
    tasks = await LocalDatabase.getAllTasks();

    setState(() {});
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      selectTasks.clear();
    });
    for (int i = 0; i < tasks.length; i++) {
      if (today.toString().split(" ")[0] ==
          tasks[i].deadline.toString().split(" ")[0]) {
        selectTasks.add(tasks[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              70.getH(),
              Text(
                "Calendar",
                style: AppTextStyle.latoBold.copyWith(fontSize: 22),
              ),
              16.getH(),
              Container(
                  child: TableCalendar(
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(color: Colors.blue),
                  weekNumberTextStyle: TextStyle(color: Colors.red),
                  weekendTextStyle: TextStyle(color: Colors.pink),
                  holidayTextStyle: TextStyle(color: Colors.pink),
                ),
                headerStyle: HeaderStyle(
                    formatButtonTextStyle: AppTextStyle.latoMedium,
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: AppTextStyle.latoBold,
                    decoration: BoxDecoration(
                        color: AppColors.c_363636,
                        borderRadius: BorderRadius.circular(4.w))),
                onDaySelected: _onDaySelected,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
              )),
              Column(
                children: selectTasks.isEmpty
                    ? [
                        Text(
                          'No tasks for selected day',
                          style: AppTextStyle.latoSemiBold,
                        )
                      ]
                    : List.generate(
                        selectTasks.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 12.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColors.c_363636),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    selectTasks[index].title,
                                    style: AppTextStyle.latoBold,
                                  ),
                                  Spacer(),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.c_FF9680,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        selectTasks[index].category,
                                        style: AppTextStyle.latoBold,
                                      )),
                                  8.getW(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.c_8687E7),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.flag,
                                          height: 24.h,
                                        ),
                                        5.getW(),
                                        Text(
                                          selectTasks[index]
                                              .priority
                                              .toString(),
                                          style: AppTextStyle.latoBold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              8.getH(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${selectTasks[index].deadline.year.toString()}-${selectTasks[index].deadline.month.toString().padLeft(2, '0')}-${selectTasks[index].deadline.day.toString().padLeft(2, '0')} ${selectTasks[index].deadline.hour.toString().padLeft(2, '0')}-${selectTasks[index].deadline.minute.toString().padLeft(2, '0')}",
                                    style: AppTextStyle.latoBold
                                        .copyWith(color: AppColors.c_AFAFAF),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
