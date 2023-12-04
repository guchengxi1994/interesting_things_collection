// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/color_utils.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'list_item.dart';
import 'listview_header.dart';
import 'new_list_item.dart';

class BoardList extends ConsumerStatefulWidget {
  const BoardList({super.key, required this.kanbanData});
  final KanbanData kanbanData;

  @override
  ConsumerState<BoardList> createState() => _BoardListState();
}

class _BoardListState extends ConsumerState<BoardList> {
  late final KanbanData? _kanbanData = ref
      .read(kanbanBoardNotifier.notifier)
      .getDataByIndex(widget.kanbanData.id!);
  late final List<KanbanItem> _items = _kanbanData == null
      ? []
      : _kanbanData!.items.sorted((a, b) => a.orderNum.compareTo(b.orderNum));
  late final List<Widget> _rows = _items
      .mapIndexed((i, e) => ListItem(
            key: ValueKey(widget.kanbanData.name.toString() + e.id.toString()),
            kanbanItem: e,
            index: i,
          ) as Widget)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: 300,
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        header: ListHeader(
          title: widget.kanbanData.name ?? "",
          stateColor: ColorUtil.getColorFromHex(widget.kanbanData.color),
          onItemAdd: () {
            if (_rows.isNotEmpty && _rows.first.runtimeType == NewListItem) {
              return;
            }

            setState(() {
              _rows.insert(
                  0,
                  NewListItem(
                    key: UniqueKey(),
                    onCreate: (String s) {
                      ref
                          .read(kanbanBoardNotifier.notifier)
                          .newItem(widget.kanbanData, s);
                    },
                    onRemove: () {
                      setState(() {
                        _rows.removeAt(0);
                      });
                    },
                  ));
            });
          },
        ),
        children: _rows,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);

            int index = 0;
            for (final i in _items) {
              i.orderNum = index;
              index += 1;
            }
          });

          ref
              .read(kanbanBoardNotifier.notifier)
              .kanbanListReorder(_kanbanData!, _items);
        },
      ),
    );
  }
}
