import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/catalog/models/things_state.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/thing.dart';
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

  Future updateThing(Thing thing) async {
    await _database.isar!.writeTxn(() async {
      await _database.isar!.things.put(thing);
    });

    final index = state.value!.thingsList.indexOf(thing);
    state.value!.thingsList.removeAt(index);
    state.value!.thingsList.insert(index, thing);

    state = await AsyncValue.guard(() async {
      return state.value!;
    });
  }

  Future newThing(Thing thing) async {
    state = const AsyncValue.loading();
    await _database.isar!.writeTxn(() async {
      await _database.isar!.things.put(thing);
    });

    state = await AsyncValue.guard(() async {
      return ThingsState(
          catalogId: state.value!.catalogId,
          pageId: state.value!.pageId,
          thingsList: state.value!.thingsList..add(thing));
    });
  }
}
