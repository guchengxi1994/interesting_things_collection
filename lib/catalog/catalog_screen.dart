import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/catalog/notifiers/catalog_notifier.dart';
import 'package:weaving/catalog/components/catalog_card.dart';
import 'package:weaving/isar/catalog.dart';
import 'package:reorderables/reorderables.dart';
import 'package:weaving/notifier/fast_search_region_notifier.dart';

import 'components/add_catalog_dialog.dart';
import 'components/catalog_things.dart';

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CatalogScreenState();
  }
}

class CatalogScreenState extends ConsumerState<CatalogScreen> {
  late final notifier = ref.watch(catalogNotifier);
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
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

  // ignore: avoid_init_to_null
  CatalogCopy? selectedCatalog = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      key: globalKey,
      backgroundColor: Colors.transparent,
      endDrawer: Drawer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.white,
        width: 0.8 * MediaQuery.of(context).size.width,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide(width: 1, color: Colors.black),
                  top: BorderSide(width: 1, color: Colors.black)),
              color: Colors.white),
          // color: Colors.white,
          width: 0.8 * MediaQuery.of(context).size.width,
          child: CatalogThingsWidget(
            catalog: selectedCatalog,
          ),
        ),
      ),
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
                            catalogId: e.id,
                            onDoubleClick: () {
                              setState(() {
                                selectedCatalog = e;
                                e.used = true;
                                ref
                                    .read(catalogNotifier.notifier)
                                    .updateCatalog(e);
                              });
                              globalKey.currentState!.openEndDrawer();
                            },
                          ))
                      .toList(),
                ),
              );
            }
            return Container();
          }),
      floatingActionButton: FittedBox(
        child: Column(
          children: [
            FloatingActionButton(
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
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              heroTag: "search",
              onPressed: () {
                ref.read(fastSearchNotifier.notifier).changeStatus(true);
              },
              child: const Icon(Icons.search),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Delete")
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
