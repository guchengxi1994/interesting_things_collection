import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reorderables/reorderables.dart';
import 'package:weaving/isar/kanban.dart';

import '../notifiers/board_notifier.dart';
import '../notifiers/board_notifier_state.dart';
import 'board_list.dart';

class CustomBoard extends ConsumerStatefulWidget {
  const CustomBoard({super.key});

  @override
  ConsumerState<CustomBoard> createState() => _BoardState();
}

class _BoardState extends ConsumerState<CustomBoard> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kanbanBoardNotifier);

    return switch (state) {
      AsyncValue<BoardNotifierState>(:final value?) => Builder(builder: (c) {
          // ignore: no_leading_underscores_for_local_identifiers
          final List<KanbanData> _columns = value.kanbanData
            ..sort((a, b) => a.orderNum.compareTo(b.orderNum));

          return IntrinsicWidth(
            child: ReorderableRow(
              scrollController: ScrollController(),
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  KanbanData c = _columns.removeAt(oldIndex);
                  _columns.insert(newIndex, c);
                });
                ref
                    .read(kanbanBoardNotifier.notifier)
                    .kanbanReorder(_columns.map((e) => e.name ?? "").toList());
              },
              children: _columns
                  .map((e) => BoardList(
                        key: ValueKey(e.name),
                        kanbanData: e,
                      ))
                  .toList(),
            ),
          );
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
