import 'package:flutter/material.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.home_rounded, 'label': 'HOME'},
    {'icon': Icons.auto_graph_rounded, 'label': 'STATS'},
    {'icon': Icons.fitness_center, 'label': 'WORKOUTS'},
    {'icon': Icons.person_outline, 'label': 'PROFILE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _items.length,
          (i) => GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == i
                          ? AppColors.accent.withValues(alpha: 0.18)
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      _items[i]['icon'] as IconData,
                      size: 22,
                      color: _selectedIndex == i
                          ? AppColors.primaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppText.small(
                    _items[i]['label'] as String,
                    fontSize: 10,
                    fontWeight: _selectedIndex == i
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: _selectedIndex == i
                        ? AppColors.primaryDark
                        : AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
