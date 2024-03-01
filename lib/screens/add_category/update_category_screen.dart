import 'package:flutter/material.dart';
import 'package:todo_app/data/local/local_database.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';
import "package:flutter_svg/svg.dart";

import '../../models/category/category_model.dart';
import '../../utils/colors/app_colors.dart';

class UpdateCategoryScreen extends StatefulWidget {
   const UpdateCategoryScreen(
      {super.key, required this.id});

   final int id;



  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

CategoryModel categoryModel = CategoryModel.initialValue;

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final TextEditingController nameController = TextEditingController();
  int activeIconIndex = 0;
  int activeColorIndex = 0;

  List<String> icons = [
    AppImages.grocery,
    AppImages.work,
    AppImages.sport,
    AppImages.design,
    AppImages.university,
    AppImages.social,
    AppImages.movie,
    AppImages.music,
    AppImages.health,
    AppImages.homeIcon
  ];

  List<Color> colors = [
    AppColors.c_8687E7,
    AppColors.c_80FFD1,
    AppColors.c_80FFA3,
    AppColors.c_FF9680,
    AppColors.c_809CFF,
    AppColors.c_80FFFF,
    AppColors.c_FF80EB
  ];

  List <CategoryModel> categories = [];


  _init ()async{
    await LocalDatabase.updateCategory(categoryModel, 10);
    setState(() {

    });
  }
  @override
  void initState() {
    _init();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          70.getH(),
          Text(
            "Update category",
            style: AppTextStyle.latoBold.copyWith(fontSize: 20.w),
          ),
          20.getH(),
          Text(
            "Category name :",
            style: AppTextStyle.latoRegular.copyWith(fontSize: 16.w),
          ),
          16.getH(),
          TextField(
            controller: nameController,
            onChanged: (v) {
              categoryModel = categoryModel.copyWith(name: v);
            },
            style: AppTextStyle.latoBold,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: AppColors.c_363636,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                hintText: "Category name",
                hintStyle: AppTextStyle.latoRegular
                    .copyWith(fontSize: 18.w, color: AppColors.c_AFAFAF),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.c_AFAFAF),
                    borderRadius: BorderRadius.circular(4.w)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.c_AFAFAF),
                    borderRadius: BorderRadius.circular(4.w))),
          ),
          20.getH(),
          Text(
            "Category icon :",
            style: AppTextStyle.latoRegular.copyWith(fontSize: 16.w),
          ),
          20.getH(),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      icons.length,
                      (index) => IconButton(
                            onPressed: () {
                              String icon = icons[index];
                              categoryModel = categoryModel.copyWith(iconPath: icon);

                              setState(() {
                                activeIconIndex = index;
                              });
                            },
                            icon: Container(
                                padding: EdgeInsets.all(4),
                                color: index == activeIconIndex
                                    ? AppColors.c_AFAFAF
                                    : AppColors.transparent,
                                child: SvgPicture.asset(icons[index])),
                          ))
                ],
              )),
          20.getH(),
          Text(
            "Category color :",
            style: AppTextStyle.latoRegular.copyWith(fontSize: 16.w),
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      colors.length,
                      (index) => IconButton(
                            onPressed: () {
                              Color color = colors[index];
                              categoryModel = categoryModel.copyWith(color: color);
                              setState(() {
                                activeColorIndex = index;
                              });
                            },
                            icon: Stack(
                              children: [
                                Container(
                                  height: 45.h,
                                  width: 45.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors[index]),
                                ),
                                Visibility(
                                  visible:
                                      index == activeColorIndex ? true : false,
                                  child: Positioned(
                                      left: 0,
                                      right: 0,
                                      child: Icon(Icons.check)),
                                )
                              ],
                            ),
                          ))
                ],
              )),
          Spacer(),
          Row(
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
                onPressed: () async {
                  print(categoryModel.iconPath);
                  print(categoryModel.color);
                  print(categoryModel.name);
                  if (categoryModel.canAddCategoryToDatabase()){

                    await LocalDatabase.updateCategory(categoryModel,widget.id!);
                    _init();
                    Navigator.pop(context);
                  }

                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 17.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    color: AppColors.c_8687E7,
                  ),
                  child: Text(
                    "Update Category",
                    style: AppTextStyle.latoRegular,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () async {

                await LocalDatabase.deleteCategory(widget.id!);
                _init();
                Navigator.pop(context);


            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w, vertical: 17.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.w),
                color: Colors.red,
              ),
              child: Text(
                "Delete Category",
                style: AppTextStyle.latoRegular,textAlign: TextAlign.center,
              ),
            ),
          ),

        ]),
      ),
    );
  }
}
