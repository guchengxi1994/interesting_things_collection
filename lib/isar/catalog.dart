import 'package:isar/isar.dart';

part 'catalog.g.dart';

@collection
class Catalog {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  List<String>? tags;

  @override
  bool operator ==(Object other) {
    if (other is! Catalog) {
      return false;
    }
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
