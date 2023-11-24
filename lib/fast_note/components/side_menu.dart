import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:weaving/fast_note/fast_note_notifier.dart';
import 'package:weaving/fast_note/fast_note_state.dart';
import 'package:weaving/isar/fast_note.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(fastNoteNotifier);

    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 236, 243, 236),
                offset: Offset(6.0, 0), //阴影y轴偏移量
                blurRadius: 2, //阴影模糊程度
                spreadRadius: 1 //阴影扩散程度
                )
          ],
        ),
        width: 200,
        child: Builder(builder: (c) {
          return switch (notes) {
            AsyncValue<FastNoteState>(:final value?) =>
              GroupedListView<FastNote, String>(
                stickyHeaderBackgroundColor: Colors.transparent,
                elements: value.notes,
                groupBy: (element) =>
                    element.isFav ? "Favorite" : element.group,
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1.createAt.compareTo(item2.createAt),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: false,
                groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                itemBuilder: (c, element) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20)),
                    ),
                    child: Text(element.key ?? ""),
                  );
                },
              ),
            _ => const Center(
                child: CircularProgressIndicator(),
              )
          };
        }));
  }
}
