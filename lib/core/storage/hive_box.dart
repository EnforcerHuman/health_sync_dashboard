import 'package:hive/hive.dart';
import 'package:health_sync_dashboard/features/health_dashboard/data/models/steps_history_model.dart';

import 'hive_init.dart';

class StepsCacheService {
  Box<StepsHistoryModel> get _box =>
      Hive.box<StepsHistoryModel>(HiveInit.stepsBoxName);

  int readSteps() {
    return _box.get(_todayKey())?.steps ?? 0;
  }

  DateTime? readUpdatedAt() {
    return _box.get(_todayKey())?.lastSyncedAt;
  }

  Future<void> saveSteps(int steps, {DateTime? updatedAt}) async {
    final timestamp = updatedAt ?? DateTime.now();
    final dayKey = _dayKey(timestamp);
    final model = StepsHistoryModel(
      dayKey: dayKey,
      steps: steps,
      lastSyncedAt: timestamp,
    );
    await _box.put(dayKey, model);
  }

  Future<void> clearIfStale({DateTime? now}) async {
    // History is retained per day, so there is nothing to clear here.
  }

  String _todayKey() => _dayKey(DateTime.now());

  String _dayKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
