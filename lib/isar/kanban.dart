import 'package:isar/isar.dart';

part 'kanban.g.dart';

@collection
class KanbanData {
  Id? id;
  String? name;
  String color = "FFFFFF";
  final items = IsarLinks<KanbanItem>();
  int orderNum = 1;
}

@collection
class KanbanItem {
  Id? id;
  String? title;
  int deadline =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch;
  int createAt = DateTime.now().millisecondsSinceEpoch;
  List<int> tagIds = [];
  int priority = 1;
  int orderNum = 1;
}

@collection
class KanbanItamTag {
  Id? id;
  String? title;
  String? color;
}
