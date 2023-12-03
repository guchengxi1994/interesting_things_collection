import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/color_utils.dart';
import 'package:weaving/isar/kanban.dart';

import 'listview_header.dart';

class BoardList extends ConsumerStatefulWidget {
  const BoardList({Key? key, required this.kanbanData}) : super(key: key);
  final KanbanData kanbanData;

  @override
  ConsumerState<BoardList> createState() => _BoardListState();
}

class _BoardListState extends ConsumerState<BoardList> {
  late final List<Widget> _rows = widget.kanbanData.items
      .map((e) => SizedBox(
            key: ValueKey(widget.kanbanData.name.toString() + e.id.toString()),
            child: Text(e.title.toString()),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      width: 300,
      child: ReorderableListView(
        header: ListHeader(
          title: widget.kanbanData.name ?? "",
          stateColor: ColorUtil.getColorFromHex(widget.kanbanData.color),
        ),
        children: _rows,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Widget item = _rows.removeAt(oldIndex);
            _rows.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
