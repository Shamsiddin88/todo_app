import 'package:flutter/material.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/constants/storage_keys.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

import '../../models/on_board_view.dart';
import '../../utils/images/app_images.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int activeIndex = 0;

  final PageController pageController = PageController();

  List <OnBoardView> onBoardView = [
    OnBoardView(title: "Manage your tasks",
        subtitle: "You can easily manage all of your daily tasks in DoMe for free",
        imagePath: AppImages.onboardingImageThree),
    OnBoardView(title: "Create daily routine",
        subtitle: "In Uptodo  you can create your personalized routine to stay productive",
        imagePath: AppImages.onboardingImageTwo),
    OnBoardView(title: "Orgonaize your tasks",
        subtitle: "You can organize your daily tasks by adding your tasks into separate categories",
        imagePath: AppImages.onboardingImageOne),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: TextButton(onPressed: () {Navigator.pushNamed(context, RouteNames.tabBox);
      StorageRepository.setBool(key: StorageKeys.onBoardingRoute, value: true);},
          child: Text("SKIP", style: AppTextStyle.latoRegular.copyWith(
              fontSize: 16.w, color: AppColors.white.withOpacity(.44)),)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 36.w),
        child: Stack(
          children: [
            Column(
              children: [
                25.getH(),
                SizedBox(
                  height: 510,
                  child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.horizontal
                      , children: List.generate(onBoardView.length, (index) =>
                      Column(children: [
                        Image.asset(onBoardView[index].imagePath, height: 277
                            .h,),
                        105.getH(),
                        Text(onBoardView[index].title, style: AppTextStyle
                            .latoBold.copyWith(fontSize: 32.w,
                            color: AppColors.white.withOpacity(.87)),
                          textAlign: TextAlign.center,),
                        42.getH(),
                        Text(onBoardView[index].subtitle, style: AppTextStyle
                            .latoRegular.copyWith(fontSize: 16.w,
                            color: AppColors.white.withOpacity(.87)),
                          textAlign: TextAlign.center,),

                      ],))),
                ),
                100.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () {
                      if (activeIndex >0){
                        activeIndex--;
                      }
                      _scrollPage(activeIndex);
                      setState(() {

                      });
                    },
                        child: Text("BACK",
                          style: AppTextStyle.latoRegular.copyWith(
                              fontSize: 16.w,
                              color: AppColors.white.withOpacity(.44)),
                          textAlign: TextAlign.center,)),
                    TextButton(style: TextButton.styleFrom(
                        backgroundColor: AppColors.c_8875FF,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 12.h)), onPressed: () async {
                      if (activeIndex < onBoardView.length-1){
                        activeIndex++;
                         }
                      else {
                      await StorageRepository.setBool(key: StorageKeys.onBoardingRoute, value: true);
                      Navigator.pushNamed(context, RouteNames.tabBox);}
                      _scrollPage(activeIndex);
                      setState(() {

                      });
                    }, child: Text("NEXT", style: AppTextStyle.latoRegular,))
                  ],)
              ],),
            Positioned(
              left: 0,
              right: 0,
              top: 350.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      onBoardView.length,
                          (index) =>
                          Container(
                            margin: const EdgeInsets.all(6),
                            width: 26,
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: index == activeIndex
                                  ? AppColors.white
                                  : AppColors.white.withOpacity(.3),
                            ),
                          ))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  _scrollPage(int index) {
    pageController.animateToPage(
        index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
