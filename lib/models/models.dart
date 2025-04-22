import 'package:hive_ce_flutter/hive_flutter.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class Taskmodel {
  Taskmodel({
    required this.title,
    required this.subTitle,
  });
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subTitle;
  @HiveField(2)
  bool done = false;
  @HiveField(3)
  DateTime createdAt = DateTime.now();
}
