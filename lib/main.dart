import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/routes/app_routes.dart';
import 'package:reduce_food_waste/views/views_exporter.dart';

import 'views/utils/utils_exporter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Common.applicationName,
      initialRoute: AppRoutes.initialRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appWhiteColor,
        appBarTheme: AppBarTheme(
          color: AppColors.appBlueColor,
          titleTextStyle: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      routes: {
        AppRoutes.initialRoute: (context) => Splash(),
        AppRoutes.onBoardingRoute: (context) => OnBoarding(),
        AppRoutes.loginRoute: (context) => Login(),
        AppRoutes.registerRoute: (context) => Register(),
        AppRoutes.forgetPasswordRoute: (context) => ForgetPassword(),
        AppRoutes.dashboardRoute: (context) => Dashboard(),
      },
    );
  }
}
