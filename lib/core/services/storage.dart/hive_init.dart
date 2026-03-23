import 'package:hive_flutter/hive_flutter.dart';
import 'package:health_sync_dashboard/features/health_dashboard/data/models/steps_history_model.dart';

class HiveInit {
  static const String stepsBoxName = 'steps_box';

  Future<void> initialize() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(StepsHistoryModelAdapter().typeId)) {
      Hive.registerAdapter(StepsHistoryModelAdapter());
    }
    await Hive.openBox<StepsHistoryModel>(stepsBoxName);
  }
}
