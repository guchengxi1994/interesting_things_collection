import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/catalog_notifier.dart';
import 'package:interesting_things_collection/catalog/components/catalog_card.dart';
import 'package:reorderables/reorderables.dart';

import 'components/add_catalog_dialog.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CatalogScreenState();
  }
}

class CatalogScreenState extends ConsumerState<CatalogScreen> {
  late final notifier = ref.watch(catalogNotifier);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        while (notifier.database.isar == null) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
        ref.read(catalogNotifier).queryAll();
      },
    );
  }

  bool bottomShow = false;
  int currentDraggingId = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder(
          stream: notifier.streamController.stream,
          builder: (c, s) {
            if (s.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ReorderableWrap(
                  spacing: 40,
                  runSpacing: 40,
                  onReorder: (int oldIndex, int newIndex) async {
                    if (s.data!.isEmpty || s.data!.length == 1) {
                      return;
                    }
                    ref.read(catalogNotifier).changeIndex(oldIndex, newIndex);
                    setState(() {
                      bottomShow = false;
                      currentDraggingId = -1;
                    });
                  },
                  onReorderStarted: (index) {
                    setState(() {
                      bottomShow = true;
                      currentDraggingId = index;
                    });
                  },
                  onNoReorder: (index) {
                    setState(() {
                      bottomShow = false;
                    });
                  },
                  children: s.data!
                      .map((e) => CatalogCard(
                            catalog: e,
                          ))
                      .toList(),
                ),
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
              context: context,
              pageBuilder: (c, a, b) {
                return const Center(
                  child: AddCatalogDialog(),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      bottomSheet: bottomShow
          ? MouseRegion(
              onEnter: (event) async {
                final r = await showCupertinoDialog(
                    context: context,
                    builder: (c) {
                      return CupertinoAlertDialog(
                        title: const Text("Delete this catalog ?"),
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(c).pop(true);
                              },
                              child: const Text("Yes")),
                          CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(c).pop(false);
                              },
                              child: const Text("No")),
                        ],
                      );
                    });

                if (r) {
                  ref.read(catalogNotifier).deleteCatalog(currentDraggingId);
                }
                setState(() {
                  currentDraggingId = -1;
                });
              },
              child: const SizedBox(
                height: 50,
                child: Center(
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
