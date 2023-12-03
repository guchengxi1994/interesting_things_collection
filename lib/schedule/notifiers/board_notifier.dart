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
