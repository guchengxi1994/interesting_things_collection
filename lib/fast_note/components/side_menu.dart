import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:like_button/like_button.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';
import 'package:weaving/fast_note/notifiers/fast_note_state.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/style/app_style.dart';

import 'search_text_field.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(fastNoteNotifier);

    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: AppStyle.leftTopRadius,
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 236, 243, 236),
                offset: Offset(6.0, 0), //阴影y轴偏移量
                blurRadius: 2, //阴影模糊程度
                spreadRadius: 1 //阴影扩散程度
                )
          ],
        ),
        width: 250,
        child: Column(
          children: [
            const SearchTextField(),
            Expanded(
              child: Builder(builder: (c) {
                return switch (notes) {
                  AsyncValue<FastNoteState>(:final value?) =>
                    GroupedListView<FastNote, String>(
                      stickyHeaderBackgroundColor: Colors.transparent,
                      elements: value.notes,
                      groupBy: (element) =>
                          element.isFav ? "Favorite" : element.group,
                      groupComparator: (value1, value2) =>
                          -value2.compareTo(value1),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppStyle.titleTextColor),
                        ),
                      ),
                      itemBuilder: (c, element) {
                        return InkWell(
                          mouseCursor: SystemMouseCursors.click,
                          onTap: () {
                            ref
                                .read(fastNoteNotifier.notifier)
                                .changeCurrent(element);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              color: value.current != null &&
                                      value.current!.id == element.id
                                  ? AppStyle.catalogCardBorderColors[
                                          ref.watch(colorNotifier)]
                                      .withAlpha(80)
                                  : Colors.white,
                              // borderRadius: AppStyle.leftTopRadius,
                            ),
                            child: Row(
                              children: [
                                Expanded(child: Text(element.key ?? "")),
                                LikeButton(
                                  onTap: (b) async {
                                    // return true;
                                    if (element.isFav == true) {
                                      element.isFav = false;
                                    } else {
                                      element.isFav = true;
                                    }
                                    Future.delayed(element.isFav
                                            ? const Duration(milliseconds: 1050)
                                            : const Duration(milliseconds: 50))
                                        .then((value) async {
                                      await ref
                                          .read(fastNoteNotifier.notifier)
                                          .updateNote(element);
                                    });
                                    return element.isFav;
                                  },
                                  isLiked: element.isFav,
                                  size: 25,
                                  circleColor: const CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.favorite,
                                      color: isLiked
                                          ? const Color.fromARGB(
                                              255, 240, 101, 147)
                                          : Colors.grey,
                                      size: 25,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    )
                };
              }),
            ),
          ],
        ));
  }
}
