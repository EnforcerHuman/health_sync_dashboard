import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';

import 'sleep_item.dart';

class SleepCard extends StatelessWidget {
  final String duration;
  final int quality;
  final String deep;
  final String rem;
  final String light;

  const SleepCard({
    super.key,
    required this.duration,
    required this.quality,
    required this.deep,
    required this.rem,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            AppColors.sleepCardGradientStart,
            AppColors.sleepCardGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.small(
                        'DURATION',
                        letterSpacing: 1.2,
                        color: AppColors.textLight.withValues(alpha: 0.7),
                      ),
                      const SizedBox(height: 4),
                      AppText.large(
                        duration,
                        color: AppColors.textLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText.small(
                        'QUALITY',
                        letterSpacing: 1.2,
                        color: AppColors.textLight.withValues(alpha: 0.7),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          AppText.large(
                            '$quality',
                            color: AppColors.textLight,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const AppText.small(
                              'GREAT',
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SleepStatItem(title: 'DEEP', value: deep),
                  SleepStatItem(title: 'REM', value: rem),
                  SleepStatItem(title: 'LIGHT', value: light),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
