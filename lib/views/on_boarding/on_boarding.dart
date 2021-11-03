import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:reduce_food_waste/views/routes/app_routes.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        color: AppColors.appWhiteColor,
        globalBackgroundColor: AppColors.appWhiteColor,
        pages: [
          PageViewModel(
            title: "Journey of reducing food waste",
            body:
                "Reducing Waste have never been easier!\nIt is all within fingertips now!",
            image: Image.asset(
                Common.assetsImages + "application_icon_with_text.png"),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.9,
              ),
              bodyTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 15.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Locate",
            body: "Discover places offering surplus food at discounted prices!",
            image: Image.asset(Common.assetsImages + "locate.jpg"),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.9,
              ),
              bodyTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 15.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Order & Pickup",
            body:
                "Your order will be waiting for you. Pick it up before time limit is up!",
            image: Image.asset(Common.assetsImages + "order_pickup.jpg"),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.9,
              ),
              bodyTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 15.0,
              ),
            ),
          ),
          PageViewModel(
            title: "Rewards",
            body:
                "Get Awarded with EXCITING surprises with accumulating points for every food waste you help reduce!",
            image: Image.asset(Common.assetsImages + "reward.jpg"),
            decoration: const PageDecoration(
              titleTextStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.9,
              ),
              bodyTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
        onDone: () => _processNavigation(),
        onSkip: () => _processNavigation(),
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: TextStyle(
            color: AppColors.appBlackColor,
            fontSize: 19.0,
          ),
        ),
        next: Text(
          "Next",
          style: TextStyle(
            color: AppColors.appBlackColor.withOpacity(0.6),
            fontSize: 19.0,
          ),
        ),
        done: Text(
          "Done",
          style: TextStyle(
            fontSize: 19.0,
            color: AppColors.primaryColor,
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          color: Colors.black26,
          activeColor: AppColors.primaryColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }

  void _processNavigation() async {
    if (ApiRequests.isLoggedIn)
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.dashboardRoute,
        (route) => false,
      );
    else
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.loginRoute,
        (route) => false,
      );
  }
}
