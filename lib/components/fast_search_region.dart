import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/highlight_text.dart';
import 'package:weaving/isar/catalog_item.dart';
import 'package:weaving/notifier/fast_search_region_notifier.dart';

class FastSearchRegion extends ConsumerStatefulWidget {
  const FastSearchRegion({super.key});

  @override
  ConsumerState<FastSearchRegion> createState() => _FastSearchRegionState();
}

class _FastSearchRegionState extends ConsumerState<FastSearchRegion> {
  static Color borderColor = Colors.grey[400]!;

  // ignore: prefer_final_fields, avoid_init_to_null
  Timer? _timer = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    textEditingController.dispose();
    super.dispose();
  }

  final TextEditingController textEditingController = TextEditingController();

  bool clearButtonVisible = false;
  List<CatalogItem> searched = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fastSearchNotifier);
    return IgnorePointer(
      ignoring: !state,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: state ? 1.0 : 0.0,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ModalBarrier(
                  onDismiss: () {
                    ref.read(fastSearchNotifier.notifier).changeStatus(false);
                  },
                  dismissible: true,
                  color: Colors.black),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                width: 0.8 * MediaQuery.of(context).size.width,
                height: 0.8 * MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 40,
                            // Add padding around the search bar
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            // Use a Material design search bar
                            child: TextField(
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
                                _timer =
                                    Timer(const Duration(milliseconds: 1000),
                                        () async {
                                  // debugPrint(textEditingController.text);
                                  // add your Code here to get the data after every given Duration

                                  searched = await ref
                                      .read(fastSearchNotifier.notifier)
                                      .queryAll(textEditingController.text);

                                  if (searched.isNotEmpty) {
                                    setState(() {});
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 10),
                                hintText: 'Search...',
                                // Add a clear button to the search bar
                                suffixIcon: SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (clearButtonVisible)
                                        TextButton(
                                            onPressed: () {
                                              textEditingController.text = "";
                                              setState(() {
                                                searched.clear();
                                                clearButtonVisible = false;
                                              });
                                            },
                                            child: const Text("清除")),
                                      IconButton(
                                        icon: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Icon(Icons.clear),
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(fastSearchNotifier.notifier)
                                              .changeStatus(false);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                // Add a search icon or button to the search bar
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(Icons.search),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: borderColor),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ))),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            itemCount: searched.length,
                            itemBuilder: (c, i) {
                              return ExpansionTile(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15)),
                                collapsedShape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text(
                                  searched[i].name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 15),
                                        child: Text.rich(
                                          HighlightText.formSpan(
                                              searched[i].fullText!,
                                              textEditingController.text),
                                        ),
                                      ))
                                ],
                              );
                            }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
