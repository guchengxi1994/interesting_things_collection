import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/catalog_item.dart';
import 'package:isar/isar.dart';

import 'catalog_details_state.dart';
import 'catalog_notifier.dart';

class CatalogDetailsNotifier extends AsyncNotifier<CatalogDetailsState> {
  final int catalogId;
  CatalogDetailsNotifier({required this.catalogId});

  final IsarDatabase database = IsarDatabase();

  @override
  FutureOr<CatalogDetailsState> build() async {
    final catalog = await database.isar!.catalogs.get(catalogId);
    final items = await database.isar!.catalogItems
        .filter()
        .catalogIdEqualTo(catalogId)
        .findAll();

    double rating = 0;

    if (items.isNotEmpty) {
      rating = items
              .map((e) => e.score ?? 0)
              .reduce((value, element) => value + element) /
          items.length;
    }

    return CatalogDetailsState(
        catalogName: catalog?.name ?? "",
        rating: rating,
        tags: catalog?.tags ?? [],
        createAt: catalog?.createdAt ?? 0);
  }

  updateCatalog(String name, List<String> tags) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final catalog = await database.isar!.catalogs.get(catalogId);

      catalog!.name = name;
      catalog.tags = tags;

      await database.isar!.writeTxn(() async {
        database.isar!.catalogs.put(catalog);
      });

      return CatalogDetailsState(
          catalogName: name,
          rating: state.value!.rating,
          tags: tags,
          createAt: state.value!.createAt);
    });

    ref.read(catalogNotifier.notifier).queryAll();
  }
}
