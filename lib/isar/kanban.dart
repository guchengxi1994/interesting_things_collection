import 'package:isar/isar.dart';

part 'kanban.g.dart';

@collection
class KanbanData {
  Id? id;
  String? name;
  String color = "FFFFFF";
  final items = IsarLinks<KanbanItam>();
  int orderNum = 1;
}

@collection
class KanbanItam {
  Id? id;
  String? title;
  int? deadline;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  List<int> tagIds = [];
  int priority = 1;
}

@collection
class KanbanItamTag {
  Id? id;
  String? title;
  String? color;
}
