import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:weaving/common/color_utils.dart';
import 'package:weaving/style/app_style.dart';

import '../notifiers/board_notifier.dart';
import '../notifiers/board_notifier_state.dart';
import 'listview_footer.dart';
import 'listview_header.dart';

class CustomBoard extends ConsumerStatefulWidget {
  const CustomBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomBoard> createState() => _BoardState();
}

class _BoardState extends ConsumerState<CustomBoard> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kanbanBoardNotifier);

    return Builder(builder: (c) {
      return switch (state) {
        AsyncValue<BoardNotifierState>(:final value?) => KanbanBoard(
            List.generate(value.kanbanData.length, (index) {
              final element = value.kanbanData.elementAt(index);
              return BoardListsData(
                  backgroundColor: const Color.fromRGBO(249, 244, 240, 1),
                  width: 350,
                  footer: const ListFooter(),
                  headerBackgroundColor: Colors.transparent,
                  header: ListHeader(
                    title: value.kanbanData[index].name ?? "",
                    stateColor: ColorUtil.getColorFromHex(
                        value.kanbanData[index].color),
                  ),
                  items: List.generate(element.items.length, (index) {
                    return Card(
                      child: Text(element.items.toList()[index].title ?? ""),
                    );
                  }));
            }),
            onItemLongPress: (cardIndex, listIndex) {},
            onItemReorder:
                (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
              print(oldCardIndex);
              print(newCardIndex);
              print(oldListIndex);
              print(newListIndex);
            },
            boardDecoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: AppStyle.leftTopRadius),
            listDecoration: const BoxDecoration(color: Colors.transparent),
            onListLongPress: (listIndex) {},
            onListReorder: (oldListIndex, newListIndex) {
              print(oldListIndex);
              print(newListIndex);
            },
            onItemTap: (cardIndex, listIndex) {},
            onListTap: (listIndex) {},
            onListRename: (oldName, newName) {},
            backgroundColor: Colors.transparent,
            displacementY: 124,
            displacementX: 100,
            textStyle: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    });
  }
}
