import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/catalog/models/catalog_items_state.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/catalog_item.dart';
import 'package:isar/isar.dart';

class ItemsNotifier extends AsyncNotifier<CatalogItemsState> {
  final IsarDatabase _database = IsarDatabase();
  final CatalogCopy catalog;
  ItemsNotifier({required this.catalog});

  @override
  FutureOr<CatalogItemsState> build() async {
    List<CatalogItem> list = await _database.isar!.catalogItems
        .filter()
        .catalogIdEqualTo(catalog.id)
        .limit(10)
        .findAll();

    return CatalogItemsState(catalogId: catalog.id, list: list, pageId: 1);
  }

  queryMore() async {
    int count = await _database.isar!.catalogItems
        .filter()
        .catalogIdEqualTo(catalog.id)
        .count();

    if (count <= state.value!.list.length) {
      return;
    }

    final pageId = state.value!.pageId;
    final items = state.value!.list;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<CatalogItem> thingsList = await _database.isar!.catalogItems
          .filter()
          .catalogIdEqualTo(catalog.id)
          .offset(pageId * 10)
          .limit(10)
          .findAll();

      return CatalogItemsState(
          catalogId: catalog.id,
          pageId: pageId + 1,
          list: items..addAll(thingsList));
    });
  }

  Future updateItem(CatalogItem item) async {
    await _database.isar!.writeTxn(() async {
      await _database.isar!.catalogItems.put(item);
    });

    final index = state.value!.list.indexOf(item);
    state.value!.list.removeAt(index);
    state.value!.list.insert(index, item);

    state = await AsyncValue.guard(() async {
      return state.value!;
    });
  }

  Future newItem(CatalogItem item) async {
    state = const AsyncValue.loading();
    await _database.isar!.writeTxn(() async {
      await _database.isar!.catalogItems.put(item);
    });

    state = await AsyncValue.guard(() async {
      return CatalogItemsState(
          catalogId: state.value!.catalogId,
          pageId: state.value!.pageId,
          list: state.value!.list..add(item));
    });
  }

  Future deleteItem(CatalogItem item) async {
    state = const AsyncValue.loading();
    final index = state.value!.list.indexOf(item);

    await _database.isar!.writeTxn(() async {
      await _database.isar!.catalogItems.delete(item.id);
    });

    state = await AsyncValue.guard(() async {
      return CatalogItemsState(
          catalogId: state.value!.catalogId,
          pageId: state.value!.pageId,
          list: state.value!.list..removeAt(index));
    });
  }
}
