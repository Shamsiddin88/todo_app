import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/utils/size/size_utils.dart';

import '../../utils/constants/storage_keys.dart';
import '../../utils/images/app_images.dart';
import '../../utils/styles/app_text_style.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    StorageRepository();
    bool isEnteredBefore =
        StorageRepository.getBool(key: StorageKeys.onBoardingRoute);
    print("ON BOARDING State: $isEnteredBefore");
    Future.delayed(const Duration(seconds: 3), () {
      if (isEnteredBefore) {
        Navigator.pushNamed(context, RouteNames.tabBox);
      } else {
        Navigator.pushNamed(context, RouteNames.onboard);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.logo,
              height: 80.h,
            ),
            19.getH(),
            Text("UpTodo",
                style: AppTextStyle.latoBold.copyWith(fontSize: 40.w)),
          ],
        ),
      ),
    );
  }
}
