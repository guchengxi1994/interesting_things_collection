import 'package:flutter/material.dart';
import 'package:weaving/isar/fast_note.dart';
import 'package:weaving/style/app_style.dart';

class ExportFastnoteDialog extends StatefulWidget {
  const ExportFastnoteDialog({super.key, required this.notes});
  final List<FastNote> notes;

  @override
  State<ExportFastnoteDialog> createState() => _ExportFastnoteDialogState();
}

class _ExportFastnoteDialogState extends State<ExportFastnoteDialog> {
  late List<bool> checkStatus = List.filled(widget.notes.length, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 0.8 * MediaQuery.of(context).size.width,
      height: 0.8 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              )
            ],
          ),
          Expanded(
              flex: 1,
              child: ListView.separated(
                  itemBuilder: (c, i) {
                    return _buildItem(i, widget.notes[i]);
                  },
                  separatorBuilder: (c, i) => const Divider(
                        color: AppStyle.titleTextColor,
                      ),
                  itemCount: widget.notes.length)),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: SelectableText(_getSelected()),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildItem(int index, FastNote note) {
    return Row(
      children: [
        Checkbox(
            value: checkStatus[index],
            onChanged: (v) {
              if (v != null) {
                setState(() {
                  checkStatus[index] = v;
                });
              }
            }),
        Expanded(
            child: Text(
          note.key.toString(),
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        )),
        FittedBox(
          child: Text(
            note.group,
            style: const TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }

  String _getSelected() {
    String s = "";
    for (int i = 0; i < checkStatus.length; i++) {
      if (checkStatus[i]) {
        s += "${widget.notes[i].group}, ${widget.notes[i].values.join(",")} 。";
      }
    }

    return s;
  }
}
