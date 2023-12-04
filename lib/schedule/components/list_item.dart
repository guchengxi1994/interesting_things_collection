import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:weaving/isar/kanban.dart';
import 'package:weaving/style/app_style.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.kanbanItem, required this.index});
  final KanbanItem kanbanItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    late String date = formatDate(
        DateTime.fromMillisecondsSinceEpoch(kanbanItem.deadline),
        [yyyy, "-", mm, "-", dd]);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(15),
      height: AppStyle.kanbanItemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kanbanItem.title.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      width: 1.5,
                      color: kanbanItem.deadline <
                              DateTime.now().millisecondsSinceEpoch
                          ? Colors.redAccent
                          : Colors.black),
                ),
                child: Text(
                  date,
                  style: TextStyle(
                      color: kanbanItem.deadline <
                              DateTime.now().millisecondsSinceEpoch
                          ? Colors.redAccent
                          : Colors.black),
                ),
              ),
              const Spacer(),
              ReorderableDragStartListener(
                index: index,
                child: const MouseRegion(
                  cursor: SystemMouseCursors.grabbing,
                  child: Icon(Icons.drag_handle),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
