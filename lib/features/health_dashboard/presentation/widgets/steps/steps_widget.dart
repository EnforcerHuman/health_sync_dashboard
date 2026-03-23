import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_sync_dashboard/common/widgets/app_text.dart';
import 'package:health_sync_dashboard/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../bloc/steps_bloc/steps_bloc.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  static const int _goalSteps = 10000;
  static const double _cardScale = 0.7;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsBloc, StepsState>(
      builder: (context, state) {
        final mediaQuery = MediaQuery.of(context);
        final screenWidth = mediaQuery.size.width;
        final screenHeight = mediaQuery.size.height;
        final baseWidth = screenWidth;
        final baseHeight = screenHeight;
        final steps = state.steps;
        final progress = (steps / _goalSteps).clamp(0.0, 1.0).toDouble();
        final stepsLeft = steps >= _goalSteps ? 0 : _goalSteps - steps;
        final status = (progress * 100).round();
        final horizontalMargin = baseWidth * 0;
        final cardWidth = baseWidth - (horizontalMargin * 2);
        final cardHeight = (baseHeight * 0.46) * _cardScale;
        final cardPaddingX = cardWidth * 0.085;
        final cardPaddingTop = (baseHeight * 0.032) * _cardScale;
        final cardPaddingBottom = (baseHeight * 0.028) * _cardScale;
        final cardRadius = (baseWidth * 0.085) * _cardScale;
        final shadowBlur = (baseWidth * 0.072) * _cardScale;
        final shadowOffsetY = (baseHeight * 0.014) * _cardScale;
        final gaugeSize = math.min(cardWidth * 0.56, cardHeight * 0.42);
        final titleSize = (baseWidth * 0.044) * _cardScale;
        final titleSpacing = (baseWidth * 0.0032) * _cardScale;
        final gapAfterTitle = (baseHeight * 0.032) * _cardScale;
        final countSize = (baseWidth * 0.103) * _cardScale;
        final subtitleSize = (baseWidth * 0.043) * _cardScale;
        final gaugeLabelGap = gaugeSize * 0.028;
        final statsTopGap = (baseHeight * 0.032) * _cardScale;
        final statLabelSize = (baseWidth * 0.032) * _cardScale;
        final statValueSize = (baseWidth * 0.051) * _cardScale;
        final statLabelSpacing = (baseWidth * 0.0023) * _cardScale;
        final statValueGap = (baseHeight * 0.008) * _cardScale;
        final dividerWidth = (baseWidth * 0.003) * _cardScale;
        final dividerHeight = (baseHeight * 0.034) * _cardScale;
        final dividerMargin = (baseWidth * 0.028) * _cardScale;
        final loadingGap = (baseHeight * 0.022) * _cardScale;
        final helperTextSize = (baseWidth * 0.03) * _cardScale;
        final permissionTextGap = (baseHeight * 0.01) * _cardScale;

        return Container(
          width: cardWidth,
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
          constraints: BoxConstraints(minHeight: cardHeight),
          padding: EdgeInsets.fromLTRB(
            cardPaddingX,
            cardPaddingTop,
            cardPaddingX,
            cardPaddingBottom,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(cardRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: shadowBlur,
                offset: Offset(0, shadowOffsetY),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AppText.small(
                  'DAILY ACTIVITY',
                  fontSize: titleSize,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: titleSpacing,
                ),
              ),
              SizedBox(height: gapAfterTitle),
              SizedBox(
                width: gaugeSize,
                height: gaugeSize,
                child: SfRadialGauge(
                  axes: [
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      startAngle: 270,
                      endAngle: 270,
                      showTicks: false,
                      showLabels: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.12,
                        thicknessUnit: GaugeSizeUnit.factor,
                        color: AppColors.divider,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      pointers: [
                        RangePointer(
                          value: status.toDouble(),
                          width: 0.12,
                          sizeUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve,
                          gradient: const SweepGradient(
                            colors: [AppColors.primary, AppColors.accent],
                            stops: [0.2, 1.0],
                          ),
                        ),
                      ],
                      annotations: [
                        GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.05,
                          widget: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText.large(
                                _formatSteps(steps),
                                fontSize: countSize,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                              SizedBox(height: gaugeLabelGap),
                              AppText.medium(
                                'Steps',
                                fontSize: subtitleSize,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: statsTopGap),
              Row(
                children: [
                  Expanded(
                    child: _StepsStat(
                      label: 'GOAL',
                      value: _formatSteps(_goalSteps),
                      valueColor: AppColors.textPrimary,
                      labelSize: statLabelSize,
                      valueSize: statValueSize,
                      labelSpacing: statLabelSpacing,
                      valueGap: statValueGap,
                    ),
                  ),
                  _StatDivider(
                    width: dividerWidth,
                    height: dividerHeight,
                    margin: dividerMargin,
                  ),
                  Expanded(
                    child: _StepsStat(
                      label: 'LEFT',
                      value: _formatSteps(stepsLeft),
                      valueColor: AppColors.primary,
                      labelSize: statLabelSize,
                      valueSize: statValueSize,
                      labelSpacing: statLabelSpacing,
                      valueGap: statValueGap,
                    ),
                  ),
                  _StatDivider(
                    width: dividerWidth,
                    height: dividerHeight,
                    margin: dividerMargin,
                  ),
                  Expanded(
                    child: _StepsStat(
                      label: 'STATUS',
                      value: '$status%',
                      valueColor: AppColors.primary,
                      labelSize: statLabelSize,
                      valueSize: statValueSize,
                      labelSpacing: statLabelSpacing,
                      valueGap: statValueGap,
                    ),
                  ),
                ],
              ),
              if (state is StepsLoadInProgress) ...[
                SizedBox(height: loadingGap),
                AppText.small(
                  'Updating...',
                  fontSize: helperTextSize,
                  color: AppColors.textSecondary,
                ),
              ],
              if (state is StepsPermissionDenied) ...[
                SizedBox(height: loadingGap),
                ElevatedButton(
                  onPressed: () =>
                      context.read<StepsBloc>().add(PermissionRequested()),
                  child: const AppText.small(
                    'Request Permission',
                    color: AppColors.textLight,
                  ),
                ),
                SizedBox(height: permissionTextGap),
                AppText.small(
                  'Permission denied. Please enable permissions in system settings.',
                  fontSize: helperTextSize,
                  textAlign: TextAlign.center,
                  color: AppColors.danger,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  String _formatSteps(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length; i++) {
      final reverseIndex = digits.length - i;
      buffer.write(digits[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }

    return buffer.toString();
  }
}

class _StepsStat extends StatelessWidget {
  const _StepsStat({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.labelSize,
    required this.valueSize,
    required this.labelSpacing,
    required this.valueGap,
  });

  final String label;
  final String value;
  final Color valueColor;
  final double labelSize;
  final double valueSize;
  final double labelSpacing;
  final double valueGap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.small(
          label,
          fontSize: labelSize,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: labelSpacing,
        ),
        SizedBox(height: valueGap),
        AppText.medium(
          value,
          fontSize: valueSize,
          color: valueColor,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider({
    required this.width,
    required this.height,
    required this.margin,
  });

  final double width;
  final double height;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.divider,
      margin: EdgeInsets.symmetric(horizontal: margin),
    );
  }
}
