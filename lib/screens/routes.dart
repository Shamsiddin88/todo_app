import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_category/add_category_screen.dart';
import 'package:todo_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:todo_app/screens/splash/splash_screen.dart';
import 'package:todo_app/screens/tab/profile/change_image_screen.dart';
import 'package:todo_app/screens/tab/tab_box.dart';

import 'add_category/update_category_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        }

      case RouteNames.onboard:
        {
          return MaterialPageRoute(builder: (context) => OnBoardingScreen());
        }

      case RouteNames.addCategory:
        {
          return MaterialPageRoute(builder: (context) => AddCategoryScreen());
        }
      case RouteNames.changeImage:
        {
          return MaterialPageRoute(builder: (context) => const ChangeImageScreen());
        }

      case RouteNames.updateCategory:
        {
          return navigate(UpdateCategoryScreen(id: settings.arguments as int));
        }

      case RouteNames.tabBox:
        {
          return MaterialPageRoute(builder: (context) => TabBox());
        }

     default:
        {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text("This kind of rout does not exist!"),
              ),
            ),
          );
        }
    }
  }

static navigate (Widget widget) {
    return MaterialPageRoute(builder: (context)=> widget);
}
}

class RouteNames{
    static const String splash = "/";
    static const String tabBox = "/tab_route";
    static const String onboard = "/on_board_route";
    static const String addCategory = "/add_category_route";
    static const String updateCategory = "/update_category_route";
    static const String changeImage = "/change_image_route";
    static const String taskRoute = "/task_route";


}