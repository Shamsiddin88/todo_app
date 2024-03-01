import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/local/local_database.dart';
import 'package:todo_app/screens/add_category/add_category_screen.dart';
import 'package:todo_app/screens/tab/home/dialogs/widget/choose_category.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';
import '../../../../models/category/category_model.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/images/app_images.dart';
import '../../../routes.dart';

Future<List<CategoryModel>> getDataItems() async {
  List<CategoryModel> savedCategories = await LocalDatabase.getAllCategories();
  return savedCategories;
}

showCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<String> categorySelection,
  required String category,
}) async {
  String selectedCategory = category;

   List<CategoryModel> categories = [
    CategoryModel(
        name: "Grocery",
        iconPath: AppImages.grocery,
        color: AppColors.c_CCFF80),
    CategoryModel(
        name: "Work", iconPath: AppImages.work, color: AppColors.c_FF9680),
    CategoryModel(
        name: "Sport", iconPath: AppImages.sport, color: AppColors.c_80FFFF),
    CategoryModel(
        name: "Design", iconPath: AppImages.design, color: AppColors.c_80FFD9),
    CategoryModel(
        name: "University",
        iconPath: AppImages.university,
        color: AppColors.c_809CFF),
    CategoryModel(
        name: "Social", iconPath: AppImages.social, color: AppColors.c_FF80EB),
    CategoryModel(
        name: "Music", iconPath: AppImages.music, color: AppColors.c_FC80FF),
    CategoryModel(
        name: "Health", iconPath: AppImages.health, color: AppColors.c_80FFA3),
    CategoryModel(
        name: "Movie", iconPath: AppImages.movie, color: AppColors.c_80D1FF),
    CategoryModel(
        name: "Home", iconPath: AppImages.homeIcon, color: AppColors.c_FFCC80),
  ];
  // debugPrint("QO'SHILGAN ID:${savedCategories[0].id.toString()}");
  final savedCategories = await getDataItems();


  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          setState((){});
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
                        children: [
                          ...List.generate(categories.length, (index) {
                            return
                              ChooseCategory(
                                  iconPath: categories[index].iconPath,
                                  color:
                                      categories[index].name == selectedCategory
                                          ? AppColors.c_8687E7
                                          : AppColors.transparent,
                                  colorItem: categories[index].color,
                                  name: categories[index].name,
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = categories[index].name;
                                    });
                                  }, onDoubleTap: () async {
                                int d = await LocalDatabase.deleteCategory(
                                    categoryModel.id!);
                                print("DELETED ID:$d");

                              },);
                          }),
                          ...List.generate(savedCategories.length, (index) {
                            return
                              ChooseCategory(
                                  iconPath: savedCategories[index].iconPath,
                                  color:  savedCategories[index].name == selectedCategory
                                          ? AppColors.c_8687E7
                                          : AppColors.transparent,
                                  colorItem: savedCategories[index].color,
                                  name: savedCategories[index].name,
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = savedCategories[index].name;

                                    });
                                  },
                                onDoubleTap: () async {
                                  Navigator.pushReplacementNamed(context, RouteNames.updateCategory, arguments:savedCategories[index].id );

                              },);
                          }),
                          ChooseCategory(
                              iconPath: AppImages.add,
                              colorItem: AppColors.c_80FFD1,
                              name: "Create New",
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RouteNames.addCategory);
                              }, onDoubleTap: () async {
                            int d = await LocalDatabase.deleteCategory(
                                categoryModel.id!);
                          },)
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextButton(
                      onPressed: () {
                        categorySelection.call(selectedCategory);
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
