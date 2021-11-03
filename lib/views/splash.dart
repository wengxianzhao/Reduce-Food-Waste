import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/routes/app_routes.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    processSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("${Common.assetsImages}application_icon_with_text.png"),
        ],
      ),
    );
  }

  void processSplash() async {
    //check firebase auth logged in status
    // bool isLoggedIn = await ApiRequests.isUserLoggedIn();
    bool isFirstTime = true;

    // checking if its first visit of user to the application or not
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isFirstTime = (sharedPreferences.getBool(Common.IS_FIRST_TIME)) == null
        ? true
        : false;
    sharedPreferences.setBool(Common.IS_FIRST_TIME, true);

    Future.delayed(const Duration(seconds: 5), () {
      ApiRequests.isLoggedIn
          ? Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.dashboardRoute, (route) => false)
          : isFirstTime
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.onBoardingRoute, (route) => false)
              : Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginRoute, (route) => false);
    });
  }
}
