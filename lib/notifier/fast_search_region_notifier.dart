import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/catalog_item.dart';

class FastSearchRegionNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  changeStatus(bool b) {
    if (state != b) {
      state = b;
    }
  }

  final IsarDatabase isarDatabase = IsarDatabase();

  Future<List<CatalogItem>> queryAll(String text) async {
    if (text == "") {
      return [];
    }

    final items = await isarDatabase.isar!.catalogItems
        .filter()
        .fullTextContains(text)
        .findAll();

    return items;
  }
}

final fastSearchNotifier = NotifierProvider<FastSearchRegionNotifier, bool>(
    () => FastSearchRegionNotifier());
