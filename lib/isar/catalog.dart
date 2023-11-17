import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'catalog.g.dart';

@collection
class Catalog {
  Id id = Isar.autoIncrement;

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  List<String>? tags;

  bool used = false;

  CatalogCopy toCatalogCopy() {
    return CatalogCopy(
        id: id,
        createdAt: createdAt,
        name: name,
        orderNum: orderNum,
        remark: remark,
        tags: tags,
        used: used);
  }

  Catalog.fromCopy(CatalogCopy catalog) {
    id = catalog.id;
    name = catalog.name;
    remark = catalog.remark;
    createdAt = catalog.createdAt;
    orderNum = catalog.orderNum;
    tags = catalog.tags;
    used = catalog.used ?? false;
  }

  Catalog();
}

class CatalogCopy with EquatableMixin {
  late int id;

  String? name;

  String? remark;

  int? createdAt;

  int? orderNum;

  List<String>? tags;

  bool? used;

  @override
  List<Object?> get props => [id, name, tags];

  CatalogCopy(
      {required this.id,
      this.createdAt,
      this.name,
      this.orderNum,
      this.remark,
      this.tags,
      this.used = false});

  CatalogCopy.from(Catalog catalog) {
    id = catalog.id;
    name = catalog.name;
    remark = catalog.remark;
    createdAt = catalog.createdAt;
    orderNum = catalog.orderNum;
    tags = catalog.tags;
    used = catalog.used;
  }
}
