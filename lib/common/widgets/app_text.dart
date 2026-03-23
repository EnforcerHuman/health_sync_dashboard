import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';

class AppText extends StatelessWidget {
  const AppText.large(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : baseStyle = const TextStyle(
         fontSize: 20,
         fontWeight: FontWeight.w600,
         color: AppColors.textPrimary,
       );

  const AppText.medium(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : baseStyle = const TextStyle(
         fontSize: 16,
         fontWeight: FontWeight.w500,
         color: AppColors.textPrimary,
       );

  const AppText.small(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : baseStyle = const TextStyle(
         fontSize: 12,
         fontWeight: FontWeight.w400,
         color: AppColors.textSecondary,
       );

  final String data;
  final TextStyle baseStyle;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? height;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
