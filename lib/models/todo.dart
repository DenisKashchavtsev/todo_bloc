import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject  {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  late bool isDone;
  @HiveField(3)
  final String category;

  Todo({
    required this.title,
    required this.description,
    required this.isDone,
    required this.category,
  });
}