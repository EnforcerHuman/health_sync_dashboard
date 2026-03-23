import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';

import '../steps_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
        title: const Text('Health Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [StepsWidget()],
        ),
      ),
    );
  }
}
