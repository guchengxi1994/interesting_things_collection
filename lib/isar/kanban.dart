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

enum ItemStatus {
  blocked(0),
  pending(1),
  inProgress(2),
  done(3);

  const ItemStatus(this.v);

  final short v;
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
