import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

import '../../../../models/category_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';

showCategorySelectDialog({
  required BuildContext context,
  // required ValueChanged<int> category,
  // required int c,
}) {
  // int cr = c;

  List<CategoryModel> categories = [
    CategoryModel(
        title: "Grocery",
        iconPath: AppImages.grocery,
        color: AppColors.c_CCFF80),
    CategoryModel(
        title: "Work", iconPath: AppImages.work, color: AppColors.c_FF9680),
    CategoryModel(
        title: "Sport", iconPath: AppImages.sport, color: AppColors.c_80FFFF),
    CategoryModel(
        title: "Design", iconPath: AppImages.design, color: AppColors.c_80FFD9),
    CategoryModel(
        title: "University",
        iconPath: AppImages.university,
        color: AppColors.c_809CFF),
    CategoryModel(
        title: "Social", iconPath: AppImages.social, color: AppColors.c_FF80EB),
    CategoryModel(
        title: "Music", iconPath: AppImages.music, color: AppColors.c_FC80FF),
    CategoryModel(
        title: "Health", iconPath: AppImages.health, color: AppColors.c_80FFA3),
    CategoryModel(
        title: "Movie", iconPath: AppImages.movie, color: AppColors.c_80D1FF),
    CategoryModel(
        title: "Home", iconPath: AppImages.homeIcon, color: AppColors.c_FFCC80),
    CategoryModel(
        title: "Create New",
        iconPath: AppImages.add,
        color: AppColors.c_80FFD1),
  ];

  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              width: double.infinity,
              margin:
                  EdgeInsets.symmetric(vertical: height / 9, horizontal: 24.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.w),
                  color: AppColors.c_363636),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  10.getH(),
                  Text(
                    "Choose Category",
                    style: AppTextStyle.latoBold.copyWith(fontSize: 18.w),
                    textAlign: TextAlign.center,
                  ),
                  20.getH(),
                  Expanded(
                    child: GridView.count(
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 16,
                        crossAxisCount: 3,
                        children: List.generate(categories.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // cr = index + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              // color: (index + 1) == cr
                              //     ? AppColors.c_8687E7
                              //     : AppColors.c_272727)

                              child: Column(
                                children: [
                                  Container(
                                    height: 64.h,
                                    width: 64.w,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        color: categories[index].color),
                                    child: SvgPicture.asset(
                                        categories[index].iconPath),
                                  ),
                                  5.getH(),
                                  Text(
                                    categories[index].title,
                                    style: AppTextStyle.latoMedium,
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextButton(
                      onPressed: () {
                        // category.call(cr);
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
                          "Add Category",
                          style: AppTextStyle.latoRegular,
                        ),
                      ),
                    ),
                  )
                ],
              ));
        });
      });
}
