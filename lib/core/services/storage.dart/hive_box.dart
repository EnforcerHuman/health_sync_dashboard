import 'package:hive/hive.dart';

import 'hive_init.dart';

class StepsCacheService {
  static const String _stepsKey = 'today_steps';
  static const String _updatedAtKey = 'today_steps_updated_at';

  Box<dynamic> get _box => Hive.box<dynamic>(HiveInit.stepsBoxName);

  int readSteps() {
    return (_box.get(_stepsKey) as int?) ?? 0;
  }

  DateTime? readUpdatedAt() {
    final raw = _box.get(_updatedAtKey) as String?;
    if (raw == null) {
      return null;
    }

    return DateTime.tryParse(raw);
  }

  Future<void> saveSteps(int steps, {DateTime? updatedAt}) async {
    final timestamp = (updatedAt ?? DateTime.now()).toIso8601String();
    await _box.put(_stepsKey, steps);
    await _box.put(_updatedAtKey, timestamp);
  }

  Future<void> clearIfStale({DateTime? now}) async {
    final timestamp = readUpdatedAt();
    final current = now ?? DateTime.now();
    if (timestamp == null) {
      return;
    }

    final isSameDay =
        timestamp.year == current.year &&
        timestamp.month == current.month &&
        timestamp.day == current.day;

    if (!isSameDay) {
      await _box.put(_stepsKey, 0);
      await _box.delete(_updatedAtKey);
    }
  }
}
