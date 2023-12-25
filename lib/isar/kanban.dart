// ignore_for_file: overridden_fields

import 'package:isar/isar.dart';
import 'package:taskboard/model/task.dart';

part 'kanban.g.dart';

@collection
class KanbanData {
  Id? id;
  String? name;
  String color = "FFFFFF";
  final items = IsarLinks<KanbanItem>();
  int orderNum = 1;

  ItemStatus getStatus() {
    switch (name) {
      case "Blocked":
        return ItemStatus.blocked;
      case "Pending":
        return ItemStatus.pending;
      case "In progress":
        return ItemStatus.inProgress;
      case "Done":
        return ItemStatus.done;
      default:
        return ItemStatus.blocked;
    }
  }
}

enum ItemStatus {
  blocked(0),
  pending(1),
  inProgress(2),
  done(3);

  const ItemStatus(this.v);

  final short v;
}

@collection
class KanbanItem extends Task {
  @override
  Id? id;
  @override
  String? title;
  @override
  int deadline =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 1))
          .millisecondsSinceEpoch;
  @override
  int createAt = DateTime.now().millisecondsSinceEpoch;
  List<int> tagIds = [];
  int priority = 1;
  int orderNum = 1;

  @enumerated
  late ItemStatus status = ItemStatus.inProgress;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["title"] = title;
    map["checked"] = status == ItemStatus.done;
    map["id"] = id;

    return map;
  }
}

@collection
class KanbanItamTag {
  Id? id;
  String? title;
  String? color;
}
