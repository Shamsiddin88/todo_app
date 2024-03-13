import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';

showPrioritySelectDialog({
  required BuildContext context,
  required ValueChanged<int> priority,
  required int p,
}) {
  int pr = p;

  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  vertical: height / 4.2, horizontal: 24.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.w),
                  color: AppColors.c_363636),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  10.getH(),
                  Text(
                    "Task Priority",
                    style: AppTextStyle.latoBold,
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: GridView.count(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.h, vertical: 20.h),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        crossAxisCount: 4,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                pr = index + 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.w),
                                  color: (index + 1) == pr
                                      ? AppColors.c_8687E7
                                      : AppColors.c_272727),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.flag,
                                    height: 24.h,
                                  ),
                                  5.getH(),
                                  Text(
                                    (index + 1).toString(),
                                    style: AppTextStyle.latoRegular,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 37.w, vertical: 17.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColors.c_363636,
                            ),
                            child: Text(
                              "Cancel",
                              style: AppTextStyle.latoRegular
                                  .copyWith(color: AppColors.c_8687E7),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            priority.call(pr);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 37.w, vertical: 17.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.w),
                              color: AppColors.c_8687E7,
                            ),
                            child: Text(
                              "Save",
                              style: AppTextStyle.latoRegular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
      });
}
