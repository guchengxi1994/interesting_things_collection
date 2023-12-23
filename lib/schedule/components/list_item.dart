import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_format/date_format.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';
import 'package:weaving/style/app_style.dart';

class ListItem extends ConsumerWidget {
  const ListItem({super.key, required this.kanbanItem, required this.index});
  final KanbanItem kanbanItem;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final List<DateTime?> defaultValue = [
      // DateTime.now(),
      DateTime.fromMillisecondsSinceEpoch(kanbanItem.deadline),
    ];

    late String date = formatDate(
        DateTime.fromMillisecondsSinceEpoch(kanbanItem.deadline),
        [yyyy, "-", mm, "-", dd]);
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Container(
            // margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,

                // border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.all(15),
            height: AppStyle.kanbanItemHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Tooltip(
                      message: kanbanItem.title.toString(),
                      waitDuration: const Duration(milliseconds: 500),
                      child: Text(
                        kanbanItem.title.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    )),
                    DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      customButton: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        // print(value);
                      },
                      dropdownStyleData: DropdownStyleData(
                        width: 250,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        offset: const Offset(0, 8),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.only(left: 16, right: 16),
                      ),
                      items: [
                        DropdownMenuItem(
                          enabled: kanbanItem.status != ItemStatus.blocked,
                          value: 1,
                          onTap: () async {
                            ref
                                .read(kanbanBoardNotifier.notifier)
                                .changeItemItemStatus(
                                    kanbanItem, ItemStatus.blocked);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.change_circle,
                                color: AppStyle.blockedColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("Mark As Blocked",
                                  style: TextStyle(
                                      color: kanbanItem.status !=
                                              ItemStatus.blocked
                                          ? Colors.black
                                          : Colors.grey))
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          enabled: kanbanItem.status != ItemStatus.done,
                          value: 2,
                          onTap: () async {
                            ref
                                .read(kanbanBoardNotifier.notifier)
                                .changeItemItemStatus(
                                    kanbanItem, ItemStatus.done);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.change_circle,
                                color: AppStyle.doneColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mark As Done",
                                style: TextStyle(
                                    color: kanbanItem.status != ItemStatus.done
                                        ? Colors.black
                                        : Colors.grey),
                              )
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          enabled: kanbanItem.status != ItemStatus.inProgress,
                          value: 3,
                          onTap: () async {
                            ref
                                .read(kanbanBoardNotifier.notifier)
                                .changeItemItemStatus(
                                    kanbanItem, ItemStatus.inProgress);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.change_circle,
                                color: AppStyle.inProgressColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("Mark As In Progress",
                                  style: TextStyle(
                                      color: kanbanItem.status !=
                                              ItemStatus.inProgress
                                          ? Colors.black
                                          : Colors.grey))
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          enabled: kanbanItem.status != ItemStatus.pending,
                          value: 4,
                          onTap: () async {
                            ref
                                .read(kanbanBoardNotifier.notifier)
                                .changeItemItemStatus(
                                    kanbanItem, ItemStatus.pending);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.change_circle,
                                color: AppStyle.pendingColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mark As Pending",
                                style: TextStyle(
                                    color:
                                        kanbanItem.status != ItemStatus.pending
                                            ? Colors.black
                                            : Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                Row(
                  children: [
                    JustTheTooltip(
                        isModal: true,
                        content: SizedBox(
                          width: 400,
                          height: 300,
                          child: CalendarDatePicker2(
                            onValueChanged: (v) {
                              // print(v);
                              if (v.isNotEmpty) {
                                if (v[0] != null) {
                                  ref
                                      .read(kanbanBoardNotifier.notifier)
                                      .changeItemStatus(kanbanItem,
                                          deadline: v[0]);
                                }
                              }
                            },
                            config: CalendarDatePicker2Config(
                              calendarType: CalendarDatePicker2Type.single,
                            ),
                            value: defaultValue,
                          ),
                        ),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1.5,
                                  color: kanbanItem.deadline <
                                          DateTime.now().millisecondsSinceEpoch
                                      ? Colors.redAccent
                                      : kanbanItem.status == ItemStatus.done
                                          ? AppStyle.doneColor
                                          : Colors.black),
                            ),
                            child: Text(
                              date,
                              style: TextStyle(
                                  color: kanbanItem.deadline <
                                          DateTime.now().millisecondsSinceEpoch
                                      ? Colors.redAccent
                                      : kanbanItem.status == ItemStatus.done
                                          ? AppStyle.doneColor
                                          : Colors.black),
                            ),
                          ),
                        )),
                    const Spacer(),
                    ReorderableDragStartListener(
                      index: index,
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.move,
                        child: Icon(Icons.drag_handle),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: Transform.rotate(
              angle: -3.14 / 4,
              child: kanbanItem.status == ItemStatus.done
                  ? const Text("Good Job")
                  : const Text("Keep Going"),
            ))
      ],
    );
  }
}
