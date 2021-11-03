import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class CategoryBlock extends StatelessWidget {
  final bool isActive;
  final String title;

  CategoryBlock({
    Key? key,
    required this.isActive,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      margin: const EdgeInsets.only(
        right: 8.0,
        bottom: 1.0,
        top: 1.0,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.appBlueColor : AppColors.appWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.appBlackColor.withOpacity(0.29),
            blurRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: isActive
              ? TextStyle(
                  color: AppColors.appWhiteColor,
                )
              : TextStyle(
                  color: AppColors.appBlackColor,
                  fontWeight: FontWeight.w700,
                ),
        ),
      ),
    );
  }
}
