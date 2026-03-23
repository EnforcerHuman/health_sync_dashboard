import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeartRateCard extends StatelessWidget {
  const HeartRateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HeartRateData> chartData = [
      HeartRateData(0, 60),
      HeartRateData(1, 65),
      HeartRateData(2, 62),
      HeartRateData(3, 70),
      HeartRateData(4, 55),
      HeartRateData(5, 80),
      HeartRateData(6, 60),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText.small(
                'HEART RATE',
                letterSpacing: 1.2,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.heart.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.heart,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText.large(
                '72',
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: AppText.small('BPM', color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 70,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              primaryXAxis: const CategoryAxis(isVisible: false),
              primaryYAxis: const NumericAxis(isVisible: false),
              series: <CartesianSeries<HeartRateData, int>>[
                SplineSeries<HeartRateData, int>(
                  dataSource: chartData,
                  xValueMapper: (data, _) => data.x,
                  yValueMapper: (data, _) => data.y,
                  color: AppColors.primaryDark,
                  width: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeartRateData {
  final int x;
  final double y;

  HeartRateData(this.x, this.y);
}
