import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/models/things_state.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/isar/database.dart';
import 'package:interesting_things_collection/isar/thing.dart';
import 'package:isar/isar.dart';

class ThingsNotifier extends AsyncNotifier<ThingsState> {
  final IsarDatabase _database = IsarDatabase();
  final Catalog catalog;
  ThingsNotifier({required this.catalog});

  @override
  FutureOr<ThingsState> build() async {
    List<Thing> thingsList = await _database.isar!.things
        .filter()
        .catalogIdEqualTo(catalog.id)
        .limit(10)
        .findAll();

    return ThingsState(
        catalogId: catalog.id, thingsList: thingsList, pageId: 1);
  }

  queryMore() async {
    int count = await _database.isar!.things
        .filter()
        .catalogIdEqualTo(catalog.id)
        .count();

    if (count <= state.value!.thingsList.length) {
      return;
    }

    final pageId = state.value!.pageId;
    final items = state.value!.thingsList;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      List<Thing> thingsList = await _database.isar!.things
          .filter()
          .catalogIdEqualTo(catalog.id)
          .offset(pageId * 10)
          .limit(10)
          .findAll();

      return ThingsState(
          catalogId: catalog.id,
          pageId: pageId + 1,
          thingsList: items..addAll(thingsList));
    });
  }
}
