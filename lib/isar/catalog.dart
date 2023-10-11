import 'package:isar/isar.dart';

part 'catalog.g.dart';

@collection
class Catalog {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? name;

  int? isDeleted;

  String? remark;

  int? createdAt;
}
