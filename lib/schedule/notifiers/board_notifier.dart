import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/isar/kanban.dart';

import 'board_notifier_state.dart';

class BoardNotifier extends AsyncNotifier<BoardNotifierState> {
  final database = IsarDatabase();

  @override
  FutureOr<BoardNotifierState> build() async {
    final list = await database.isar!.kanbanDatas.where().findAll();
    return BoardNotifierState(kanbanData: list);
  }

  Future changeStatus(int id) async {
    KanbanItem? item =
        await database.isar!.kanbanItems.where().idEqualTo(id).findFirst();
    if (item == null) {
      return;
    }

    await database.isar!.writeTxn(() async {
      if (item.status == ItemStatus.done) {
        item.status = ItemStatus.inProgress;
      } else {
        item.status = ItemStatus.done;
      }

      await database.isar!.kanbanItems.put(item);
    });
  }

  Future<List<KanbanItem>> getToday() async {
    var now = DateTime.now();
    var startOfDay = DateTime(now.year, now.month, now.day);
    var endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final l = await database.isar!.kanbanItems
        .filter()
        .createAtBetween(
            startOfDay.millisecondsSinceEpoch, endOfDay.millisecondsSinceEpoch)
        .findAll();

    // Map<String, List<KanbanItem>> m = {"data": l};

    return l;
  }

  Future<int> newItem(KanbanData kanbanData, String itemTitle) async {
    state = const AsyncValue.loading();
    KanbanItem item = KanbanItem()..title = itemTitle;
    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        await database.isar!.kanbanItems.put(item);
        kanbanData.items.add(item);
        await kanbanData.items.save();
      });

      final list = await database.isar!.kanbanDatas.where().findAll();
      return BoardNotifierState(kanbanData: list);
    });

    return item.id!;
  }

  KanbanData? getDataByIndex(int index) {
    if (state.value == null) {
      return null;
    }
    return state.value!.kanbanData
        .where((element) => element.id == index)
        .first;
  }

  kanbanListReorder(KanbanData kanbanData, List<KanbanItem> items) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await database.isar!.writeTxn(() async {
        // if (oldIndex < newIndex) {
        //   newIndex -= 1;
        // }

        // final list = kanbanData.items.toList();
        // final item = list.removeAt(oldIndex);
        // list.insert(newIndex, item);
        // int index = 0;
        // for (final i in list) {
        //   i.orderNum = index;
        //   index += 1;
        // }
        await database.isar!.kanbanItems.putAll(items);

        await kanbanData.items.save();
      });

      final list = await database.isar!.kanbanDatas.where().findAll();

      return BoardNotifierState(kanbanData: list);
    });
  }

  kanbanReorder(List<String> titles) async {
    await database.isar!.writeTxn(() async {
      int index = 0;
      for (final i in titles) {
        var data =
            state.value!.kanbanData.where((element) => element.name == i).first;
        data.orderNum = index;
        index += 1;
        await database.isar!.kanbanDatas.put(data);
      }
    });
    state = AsyncValue.data(
        BoardNotifierState(kanbanData: state.value!.kanbanData));
  }
}

final kanbanBoardNotifier =
    AsyncNotifierProvider<BoardNotifier, BoardNotifierState>(() {
  return BoardNotifier();
});
