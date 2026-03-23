import 'package:hive/hive.dart';

part 'steps_history_model.g.dart';

@HiveType(typeId: 0)
class StepsHistoryModel {
  const StepsHistoryModel({
    required this.dayKey,
    required this.steps,
    required this.lastSyncedAt,
  });

  @HiveField(0)
  final String dayKey;

  @HiveField(1)
  final int steps;

  @HiveField(2)
  final DateTime lastSyncedAt;
}
