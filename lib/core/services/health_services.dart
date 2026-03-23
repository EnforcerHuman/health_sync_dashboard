import 'dart:async';
import 'package:health/health.dart';

class HealthService {
  final Health _health = Health();

  Timer? _pollTimer;
  StreamController<int>? _stepsController;

  /// Initialize health plugin
  Future<void> init() async {
    await _health.configure();
  }

  /// Request permission
  Future<bool> requestAuthorization() async {
    final types = [HealthDataType.STEPS];

    try {
      final hasPermission = await _health.hasPermissions(types) ?? false;
      if (hasPermission) {
        return true;
      }

      final granted = await _health.requestAuthorization(types);
      return granted;
    } catch (e) {
      return false;
    }
  }

  //  1. Getting the steps
  Future<int> getSteps(DateTime start, DateTime end) async {
    try {
      final steps = await _health.getTotalStepsInInterval(start, end);
      return steps ?? 0;
    } catch (e) {
      return 0;
    }
  }

  //  2. Raw Data Method
  Future<int> getStepsFromRawData(DateTime start, DateTime end) async {
    try {
      final data = await _health.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: [HealthDataType.STEPS],
      );

      // remove duplicates (IMPORTANT)
      final cleaned = _health.removeDuplicates(data);

      int total = 0;

      for (final point in cleaned) {
        final raw = point.value;

        // Convert the raw value to string and parse as double,
        // then add its integer part to the total. This avoids
        // calling methods that may not exist on HealthValue.
        final str = raw.toString();
        final parsed = double.tryParse(str) ?? 0.0;
        total += parsed.toInt();
      }

      return total;
    } catch (e) {
      return 0;
    }
  }

  //  3. TODAY STEPS
  Future<int> getStepsForToday() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return getSteps(start, now);
  }

  // 4. STREAMING
  Future<Stream<int>?> startStepStream({
    Duration interval = const Duration(seconds: 2),
  }) async {
    await init();

    final authorized = await requestAuthorization();
    if (!authorized) {
      return null;
    }

    _pollTimer?.cancel();
    await _stepsController?.close();
    _stepsController = StreamController<int>.broadcast();

    final current = await getStepsForToday();
    _stepsController?.add(current);

    _pollTimer = Timer.periodic(interval, (_) async {
      final steps = await getStepsForToday();
      _stepsController?.add(steps);
    });

    return _stepsController!.stream;
  }

  Future<void> stopPolling() async {
    _pollTimer?.cancel();
    _pollTimer = null;
    await _stepsController?.close();
    _stepsController = null;
  }
}
