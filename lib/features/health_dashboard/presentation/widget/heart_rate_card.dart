import 'package:flutter/material.dart';
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "HEART RATE",
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1.2,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDECEC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Color(0xFFE63946),
                  size: 18,
                ),
              )
            ],
          ),

          const SizedBox(height: 8),

          /// BPM Text
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "72",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  "BPM",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          /// Syncfusion Chart
          SizedBox(
            height: 70,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              margin: EdgeInsets.zero,
              primaryXAxis: const CategoryAxis(
                isVisible: false,
              ),
              primaryYAxis: const NumericAxis(
                isVisible: false,
              ),
              series: <CartesianSeries<HeartRateData, int>>[
                SplineSeries<HeartRateData, int>(
                  dataSource: chartData,
                  xValueMapper: (data, _) => data.x,
                  yValueMapper: (data, _) => data.y,
                  color: const Color(0xFF0E6F73),
                  width: 2,
                )
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