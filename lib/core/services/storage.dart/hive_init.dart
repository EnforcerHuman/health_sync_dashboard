import 'package:hive_flutter/hive_flutter.dart';

class HiveInit {
  static const String stepsBoxName = 'steps_box';

  Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(stepsBoxName);
  }
}
