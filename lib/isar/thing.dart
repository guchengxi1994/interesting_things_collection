import 'package:isar/isar.dart';

part 'thing.g.dart';

@collection
class Thing {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  int? catalogId;

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  double? score;

  String? preview;

  String? fullText;

  @override
  bool operator ==(Object other) {
    if (other is! Thing) {
      return false;
    }
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
