import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:weaving/fast_note/notifiers/fast_note_notifier.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  static Color borderColor = Colors.grey[400]!;

  // ignore: prefer_final_fields, avoid_init_to_null
  Timer? _timer = null;

  bool clearButtonVisible = false;

  List<String> clipboardValues = [];

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() async {
      // print(focusNode.hasFocus);
      if (focusNode.hasFocus) {
        // clipboardValues.clear();
        List<String> list = [];
        final reader = await ClipboardReader.readClipboard();
        for (final i in reader.items) {
          if (i.canProvide(Formats.plainText)) {
            final text = await i.readValue(Formats.plainText);
            // print(text);
            if (text != null) {
              list.add(text);
            }
          }
        }
        if (list.isNotEmpty) {
          setState(() {
            clipboardValues = List.from(list);
          });
          justTheController.showTooltip();
        }
      }
    });
  }

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final JustTheController justTheController = JustTheController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        // Add padding around the search bar
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use a Material design search bar
        child: TextField(
          focusNode: focusNode,
          controller: textEditingController,
          onChanged: (value) {
            if (value == "") {
              if (clearButtonVisible != false) {
                clearButtonVisible = false;
                setState(() {});
              }
            } else {
              if (!clearButtonVisible) {
                clearButtonVisible = true;
                setState(() {});
              }
            }

            if (_timer?.isActive ?? false) _timer!.cancel();
            _timer = Timer(const Duration(milliseconds: 1000), () async {
              // debugPrint(textEditingController.text);
              // add your Code here to get the data after every given Duration
              ref
                  .read(fastNoteNotifier.notifier)
                  .filter(textEditingController.text);
            });
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 10),
            hintText: 'Search...',
            // Add a clear button to the search bar
            suffixIcon: clearButtonVisible
                ? TextButton(
                    onPressed: () {
                      textEditingController.text = "";
                      setState(() {
                        clearButtonVisible = false;
                      });
                      ref.read(fastNoteNotifier.notifier).filter("");
                    },
                    child: const Text("清除"))
                : const SizedBox(),
            // Add a search icon or button to the search bar
            prefixIcon: JustTheTooltip(
                controller: justTheController,
                tailBuilder: (point1, point2, point3) {
                  return Path()
                    ..moveTo(point1.dx, point1.dy)
                    ..lineTo(point3.dx, point3.dy)
                    ..close();
                },
                isModal: true,

                /// FIXME 不刷新列表
                content: SizedBox(
                  width: 300,
                  height: 300,
                  child: ListView.builder(
                    key: UniqueKey(),
                    itemBuilder: (c, i) {
                      return InkWell(
                        onTap: () {
                          textEditingController.text = clipboardValues[i];
                          ref
                              .read(fastNoteNotifier.notifier)
                              .filter(textEditingController.text);
                        },
                        child: SizedBox(
                          height: 30,
                          child: Text(clipboardValues[i]),
                        ),
                      );
                    },
                    itemCount: clipboardValues.length,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                )),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ));
  }
}
