import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'catalog.g.dart';

@collection
class Catalog with EquatableMixin {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  List<String>? tags;

  @override
  List<Object?> get props => [id, name, tags];
}
