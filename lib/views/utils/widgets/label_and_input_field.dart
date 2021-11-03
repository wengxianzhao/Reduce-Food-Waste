import 'package:flutter/material.dart';
import 'package:reduce_food_waste/views/utils/utils_exporter.dart';

class LabelAndInputField extends StatelessWidget {
  final String? label;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController fieldController;
  final Color? fieldColor, hintStyle, borderColor, labelColor, textColor;
  final EdgeInsetsGeometry? fieldPadding;
  final TextAlign? textAlign;
  final double? fieldHeight, fontSize, labelSize, borderRadius;
  final int? maxLines;
  final Widget? prefixIcon;

  LabelAndInputField({
    required this.fieldController,
    required this.label,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius,
    this.fieldColor,
    this.borderColor,
    this.labelColor,
    this.textColor,
    this.hintStyle,
    this.fieldPadding,
    this.textAlign,
    this.fieldHeight,
    this.fontSize,
    this.labelSize,
    this.maxLines,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
      ),
      padding: fieldPadding,
      child: SizedBox(
        height: fieldHeight,
        child: TextFormField(
          controller: fieldController,
          keyboardType: inputType,
          autocorrect: false,
          enableSuggestions: true,
          obscureText: obscureText,
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            labelStyle: TextStyle(
              fontSize: labelSize ?? 16.0,
              color: labelColor ?? AppColors.appBlackColor.withOpacity(0.8),
            ),
            border: outlinedBorder(),
            disabledBorder: outlinedBorder(),
            enabledBorder: outlinedBorder(),
            errorBorder: outlinedBorder(),
            focusedBorder: outlinedBorder(),
            focusedErrorBorder: outlinedBorder(),
            filled: true,
            prefixIcon: prefixIcon,
          ),
          style: TextStyle(
            color: textColor ?? AppColors.appBlackColor,
            fontSize: fontSize ?? 18.0,
            // fontFamily: "DINNextLTPro_Medium",
          ),
          textAlign: textAlign ?? TextAlign.start,
          maxLines: maxLines ?? 1,
        ),
      ),
    );
  }

  OutlineInputBorder outlinedBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 1,
          color: borderColor ?? AppColors.appBlackColor,
        ),
      );
}
