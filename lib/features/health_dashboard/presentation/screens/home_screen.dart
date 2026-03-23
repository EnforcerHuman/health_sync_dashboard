import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/common/widgets/bottom_nav_bar.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/activity_section.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/heart_rate_card.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/quick_log_section/quick_log.dart';
import 'package:health_sync_dashboard/features/health_dashboard/presentation/widget/sleep_section/sleep_card.dart';

import '../steps_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      bottomNavigationBar: BottomNavBar (),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldBg,
        title: const AppText.large('Health Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                StepsWidget(),
                SizedBox(height: 10),
                HeartRateCard(),
                SizedBox(height: 10),
                ActivitySection(calories: 1420, activeMinutes: 48),
                SizedBox(height: 10),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.large('Last Night Sleep'),
                    SizedBox(height: 5),
                    SleepCard(
                      duration: "7h 42m",
                      quality: 88,
                      deep: "1h 20m",
                      rem: "2h 15m",
                      light: "4h 07m",
                    ),
                  ],
                ),

                //quick log section
                QuickLog(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
