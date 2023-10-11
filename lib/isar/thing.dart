import 'package:isar/isar.dart';

part 'thing.g.dart';

@collection
class Thing {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  int? catalogId;

  String? name;

  int? isDeleted;

  String? remark;

  int? createdAt;
}
