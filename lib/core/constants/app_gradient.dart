import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Contains all the gradients used in the app.
/// for Sleep Card
class AppGradients {
  static const LinearGradient sleepGradient = LinearGradient(
    colors: [
      AppColors.sleepCardGradientStart,
      AppColors.sleepCardGradientEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}