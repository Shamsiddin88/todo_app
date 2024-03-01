import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/models/category/category_model.dart';
import 'package:todo_app/models/profile_settings.dart';
import 'package:todo_app/screens/tab/profile/widgets/profile_items.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileSettings> account = [
    ProfileSettings(title: "Change account name", iconPath: AppImages.profile, onTab:(){}),
    ProfileSettings(
        title: "Change account password", iconPath: AppImages.password, onTab:(){}),
    ProfileSettings(
        title: "Change account Image", iconPath: AppImages.changeImage, onTab:(){}),
  ];
  List<ProfileSettings> upTodo = [
    ProfileSettings(title: "About US", iconPath: AppImages.aboutUs, onTab:(){}),
    ProfileSettings(title: "FAQ", iconPath: AppImages.faq, onTab:(){}),
    ProfileSettings(title: "Help & Feedback", iconPath: AppImages.help, onTab:(){}),
    ProfileSettings(title: "Support US", iconPath: AppImages.support, onTab:(){}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.getH(),
            Center(
                child: Column(
              children: [
                Text(
                  "Profile",
                  style: AppTextStyle.latoRegular.copyWith(fontSize: 20.w),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Image.asset(
                    AppImages.profileOne,
                    width: 85.w,
                  ),
                ),
                Text(
                  "Martha Hays",
                  style: AppTextStyle.latoMedium.copyWith(fontSize: 20.w),
                ),
                20.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 37.w, vertical: 17.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.c_363636,
                          ),
                          child: Text(
                            "10 Task left",
                            style: AppTextStyle.latoRegular,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 37.w, vertical: 17.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.c_363636,
                          ),
                          child: Text(
                            "5 Task done",
                            style: AppTextStyle.latoRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            24.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Settings",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            4.getH(),
            ProfileItems(iconPath: AppImages.settings, title: "App Settings", onTab: (){Navigator.pushNamed(context, RouteNames.addCategory);},),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Account",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            ...List.generate(
                account.length,
                (index) => ProfileItems(
                    iconPath: account[index].iconPath,
                    title: account[index].title, onTab: () {},),),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Uptodo",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            ...List.generate(
                upTodo.length,
                (index) => ProfileItems(
                    iconPath: upTodo[index].iconPath,
                    title: upTodo[index].title, onTab: () { },)),
            TextButton(
              onPressed: (){},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(children: [
                  SvgPicture.asset(AppImages.logOut, height: 24.h,),
                  26.getW(),
                  Text("Log out", style: AppTextStyle.latoRegular.copyWith(color: AppColors.c_error),)
                ],),
              ),
            ),
            50.getH(),
          ],
        ),
      ),
    );
  }
}
