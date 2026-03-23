import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/activity_section.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/heart_rate_card.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                StepsWidget(),
                SizedBox(height: 10,)
               ,HeartRateCard(),
                 SizedBox(height: 10,),
               ActivitySection(
              calories: 1420,
              activeMinutes: 48),
               ],
            ),
          ),
        ),
      ),
    );
  }
}
