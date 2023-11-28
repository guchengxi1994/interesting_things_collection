import 'package:isar/isar.dart';

part 'catalog_item.g.dart';

@collection
class CatalogItem {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  int? catalogId;

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  double? score;

  String? preview;

  String? fullText;

  bool locked = false;

  @override
  bool operator ==(Object other) {
    if (other is! CatalogItem) {
      return false;
    }
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
