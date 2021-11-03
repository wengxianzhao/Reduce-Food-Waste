import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class EmptyUI extends StatelessWidget {
  final String title;
  final String description;
  const EmptyUI({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Lottie.asset(
          "${Common.assetsAnimations}not_found.json",
          height: 150.0,
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          style: TextStyle(
            color: AppColors.appBlackColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(color: AppColors.appGreyColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
