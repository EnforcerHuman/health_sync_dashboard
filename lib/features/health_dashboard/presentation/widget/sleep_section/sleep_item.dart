import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';

class SleepStatItem extends StatelessWidget {
  final String title;
  final String value;

  const SleepStatItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColors.textLight.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            AppText.small(
              title,
              letterSpacing: 1,
              color: AppColors.textLight.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 6),
            AppText.small(
              value,
              color: AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
