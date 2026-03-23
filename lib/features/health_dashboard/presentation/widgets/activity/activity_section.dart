import 'package:flutter/material.dart';
import 'activity_card.dart';

class ActivitySection extends StatelessWidget {
  final int calories;
  final int activeMinutes;

  const ActivitySection({
    super.key,
    required this.calories,
    required this.activeMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActivityCard(
          icon: Icons.local_fire_department,
          title: "BURNED",
          value: calories.toString(),
          unit: "kcal",
        ),
        ActivityCard(
          icon: Icons.timer,
          title: "ACTIVE",
          value: activeMinutes.toString(),
          unit: "mins",
        ),
      ],
    );
  }
}
