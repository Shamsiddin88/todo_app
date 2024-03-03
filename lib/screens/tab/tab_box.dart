import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/screens/tab/profile/profile_screen.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/size/size_utils.dart';

import '../../utils/styles/app_text_style.dart';
import 'calendar/calendar_screen.dart';
import 'home/home_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [HomeScreen(), CalendarScreen(), ProfileScreen()];

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_activeIndex],
      bottomNavigationBar: SizedBox(
        height: 100.h,
        width: double.infinity,
        child: BottomNavigationBar(
          unselectedItemColor: AppColors.c_AFAFAF,
          selectedItemColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: AppTextStyle.latoMedium.copyWith(fontSize: 12.w, color: AppColors.c_AFAFAF),
          selectedLabelStyle: AppTextStyle.latoMedium.copyWith(fontSize: 12.w, color: AppColors.white),
          onTap: (newActiveIndex){_activeIndex = newActiveIndex; setState(() {

          });},
          currentIndex: _activeIndex,
          backgroundColor: AppColors.c_363636,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.home,height: 24.h, colorFilter: ColorFilter.mode(AppColors.white.withOpacity(0.3), BlendMode.srcIn),),
                label: "Index",
                activeIcon: SvgPicture.asset(
                  AppImages.home,height: 24.h,
                  colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.calendar,height: 24.h, colorFilter: ColorFilter.mode(AppColors.white.withOpacity(0.3), BlendMode.srcIn),),
                label: "Calendar",
                activeIcon: SvgPicture.asset(
                  AppImages.calendar,height: 24.h,
                  colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                )),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.profile,height: 24.h, colorFilter: ColorFilter.mode(AppColors.white.withOpacity(0.3), BlendMode.srcIn),),
                label: "Profile",
                activeIcon: SvgPicture.asset(
                  AppImages.profile,height: 24.h,
                  colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                )),


          ],
        ),
      ),
    );
  }
}
