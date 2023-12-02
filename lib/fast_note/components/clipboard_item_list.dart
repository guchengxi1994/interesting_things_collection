import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/fast_note/notifiers/clipboard_item_notifier.dart';

typedef OnItemClicked = void Function(String);

class ClipboardItemList extends ConsumerWidget {
  const ClipboardItemList({Key? key, required this.onItemClicked})
      : super(key: key);
  final OnItemClicked onItemClicked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clipboardNotifier);

    return SizedBox(
      width: 300,
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          key: UniqueKey(),
          children: state.list.map((e) {
            return InkWell(
              onTap: () {
                onItemClicked(e);
              },
              child: SizedBox(
                height: 30,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    e,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
