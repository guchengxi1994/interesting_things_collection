// ignore: depend_on_referenced_packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/color_utils.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/schedule/components/list_item.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';
import 'package:weaving/schedule/notifiers/board_notifier_state.dart';
import 'package:taskboard/model/board.dart';
import 'package:taskboard/board_widget.dart';

import 'listview_header.dart';
import 'new_list_item.dart';

class CustomBoardV2 extends ConsumerStatefulWidget {
  const CustomBoardV2({super.key});

  @override
  ConsumerState<CustomBoardV2> createState() => _CustomBoardV2State();
}

class _CustomBoardV2State extends ConsumerState<CustomBoardV2> {
  final GlobalKey<ReorderableListState> _listKey =
      GlobalKey<ReorderableListState>();
  final ScrollController _controller = ScrollController();
  bool _isDragging = false;

  late int id = -1;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kanbanBoardNotifier);

    return switch (state) {
      AsyncValue<BoardNotifierState>(:final value?) => Builder(builder: (c) {
          // ignore: no_leading_underscores_for_local_identifiers
          final List<KanbanData> _columns = value.kanbanData
            ..sort((a, b) => a.orderNum.compareTo(b.orderNum));

          var boards = _columns
              .map((e) => Board(
                  e.name!,
                  e.items.toList()
                    ..sort((a, b) => a.orderNum.compareTo(b.orderNum))))
              .toList();

          return ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            scrollController: _controller,
            padding: const EdgeInsets.all(16),
            key: _listKey,
            dragStartBehavior: DragStartBehavior.start,
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return BoardWidget(
                board: boards[index],
                itemBuilder: (task) {
                  return ListItem(kanbanItem: task);
                },
                isDragged: true,
              );
            },
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var board = boards[index];
              KanbanData kanbanData = _columns[index];
              final List<dynamic> rows = board.tasks;
              return ReorderableDragStartListener(
                key: ValueKey(board.name),
                index: index,
                child: Listener(
                  onPointerMove: _pointerMove,
                  child: DragTarget(
                    hitTestBehavior: HitTestBehavior.translucent,
                    onWillAccept: (task) {
                      return !board.tasks.contains(task);
                    },
                    onAccept: (task) {
                      if (task != null) {
                        // print((task as KanbanItem).status);
                        ref
                            .read(kanbanBoardNotifier.notifier)
                            .moveItemTo(kanbanData, task as KanbanItem);
                      }
                    },
                    builder: (context, candidateData, rejectedData) {
                      return BoardWidget(
                        isDragging: (isDragging) {
                          _isDragging = isDragging;
                        },
                        header: ListHeader(
                          title: kanbanData.name!,
                          stateColor:
                              ColorUtil.getColorFromHex(kanbanData.color),
                          onItemAdd: () async {
                            if (rows.isNotEmpty &&
                                rows.first.runtimeType == InsertNewListItem) {
                              return;
                            }

                            /// FIXME not work
                            id = await ref
                                .read(kanbanBoardNotifier.notifier)
                                .addNewItemPreview(kanbanData.name!);
                          },
                        ),
                        onSameListReorder: (oldIndex, newIndex) {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }

                          final item = board.tasks.removeAt(oldIndex);
                          board.tasks.insert(newIndex, item);

                          int index = 0;
                          for (final i in board.tasks) {
                            (i as KanbanItem).orderNum = index;
                            index += 1;
                          }

                          ref
                              .read(kanbanBoardNotifier.notifier)
                              .kanbanListReorder(
                                  kanbanData, board.tasks as List<KanbanItem>);
                        },
                        key: ValueKey(board.hashCode),
                        itemBuilder: (task) {
                          if (task.title == "" || task.title == null) {
                            // print("aaaaaaaaaaaaaaaaa");
                            return NewListItem(
                              onCreate: (String s) {
                                // print("aaaaaaaaaaaaaaa");
                                ref
                                    .read(kanbanBoardNotifier.notifier)
                                    .newItem(kanbanData, s, id: id);
                              },
                              onRemove: () {
                                ref
                                    .read(kanbanBoardNotifier.notifier)
                                    .removeNewItemPreview(kanbanData.name!, id);
                              },
                            );
                          }
                          return ListItem(kanbanItem: task);
                        },
                        board: board,
                        addNewTaskCallback: () {},
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: boards.length,
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              KanbanData c = _columns.removeAt(oldIndex);
              _columns.insert(newIndex, c);

              ref
                  .read(kanbanBoardNotifier.notifier)
                  .kanbanReorder(_columns.map((e) => e.name ?? "").toList());
            },
          );
        }),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }

  void _pointerMove(event) {
    if (!_isDragging) {
      return;
    }
    RenderBox render = _listKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = render.localToGlobal(Offset.zero);
    double leadingX = position.dx;
    double trailingX = leadingX + render.size.width;
    const detectedRange = 100;
    if (event.position.dx < leadingX + detectedRange) {
      var to = _controller.offset - 20;
      to = (to < 0) ? 0 : to;

      _controller.jumpTo(to);
    } else if (event.position.dx > trailingX - detectedRange) {
      var to = _controller.offset + 20;
      // print(to);
      to = (to > _controller.position.maxScrollExtent)
          ? _controller.position.maxScrollExtent
          : to;
      _controller.jumpTo(to);
    }
  }
}
