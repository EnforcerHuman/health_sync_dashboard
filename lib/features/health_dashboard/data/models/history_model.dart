
import 'package:hive/hive.dart';

part 'history_model.g.dart'; 

@HiveType(typeId: 1)
class StepsHistory {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final int steps;
  @HiveField(2)
  final DateTime? updatedAt;

  StepsHistory({required this.date, required this.steps, this.updatedAt});
}