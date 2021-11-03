import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Widget? child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final Color? buttonColor;
  final bool? needShadow;

  PrimaryButton({
    Key? key,
    required this.buttonText,
    this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0),
    this.fontSize = 18.0,
    this.onPressed,
    this.buttonColor,
    this.needShadow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.appBlueColor,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: (needShadow == true)
              ? [
                  BoxShadow(
                    color: AppColors.appBlackColor.withOpacity(0.2),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(7, 4),
                  )
                ]
              : null,
        ),
        padding: padding,
        child: child ??
            Text(
              "$buttonText",
              style: TextStyle(
                color: AppColors.appWhiteColor,
                fontSize: fontSize,
                fontFamily: "DINNextLTPro_Bold",
              ),
              textAlign: TextAlign.center,
            ),
      ),
    );
  }
}
