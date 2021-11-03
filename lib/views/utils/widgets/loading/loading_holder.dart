import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHolder extends StatelessWidget {
  final Widget child;
  final Color? baseColor, highlightColor;
  const LoadingHolder({
    Key? key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.appGreyColor.withOpacity(0.25),
      highlightColor:
          highlightColor ?? AppColors.appGreyColor.withOpacity(0.15),
      child: child,
    );
  }
}
