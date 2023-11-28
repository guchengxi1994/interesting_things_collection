import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/catalog_item.dart';

class ItemsHoverNotifier extends Notifier<int> {
  final IsarDatabase _database = IsarDatabase();

  @override
  build() {
    return 0;
  }

  changeIndex(int id) {
    if (state != id) {
      state = id;
    }
  }

  /// TODO
  ///
  /// move to other notifier
  Future saveItem(CatalogItem item) async {
    await _database.isar!.writeTxn(() async {
      await _database.isar!.catalogItems.put(item);
    });
  }
}

final itemsHoverNotifier = NotifierProvider<ItemsHoverNotifier, int>(() {
  return ItemsHoverNotifier();
});
