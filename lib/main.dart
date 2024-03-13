import 'package:flutter/material.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/colors/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.init();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.black,
            elevation: 0,
          ),
          scaffoldBackgroundColor: AppColors.black,
          useMaterial3: false),
    );
  }
}
