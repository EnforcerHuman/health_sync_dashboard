import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';

class QuickLog extends StatelessWidget {
  const QuickLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.large('Quick Log', fontWeight: FontWeight.bold),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _logCard(
                icon: Icons.water_drop,
                iconColor: Colors.blue,
                bgColor: Colors.blue.shade100,
                title: 'Water Intake',
                value: '1,200 ml',
                trailing: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _logCard(
                icon: Icons.monitor_weight,
                iconColor: Colors.teal,
                bgColor: Colors.teal.shade100,
                title: 'Weight',
                value: '68.4 kg',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _logCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String value,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.small(title, color: Colors.grey.shade600),
                const SizedBox(height: 4),
                AppText.medium(value, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          ...?(trailing == null ? null : [trailing]),
        ],
      ),
    );
  }
}
