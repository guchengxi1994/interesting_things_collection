import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/catalog/models/catalog_items_state.dart';
import 'package:weaving/catalog/notifiers/items_notifier.dart';
import 'package:weaving/isar/catalog.dart';

import 'catalog_details.dart';
import 'catalog_item_widget.dart';

class CatalogItemsWidget extends ConsumerStatefulWidget {
  const CatalogItemsWidget({super.key, required this.catalog});
  final CatalogCopy? catalog;

  @override
  ConsumerState<CatalogItemsWidget> createState() => _CatalogItemsWidgetState();
}

class _CatalogItemsWidgetState extends ConsumerState<CatalogItemsWidget> {
  late final notifier = widget.catalog == null
      ? null
      : AsyncNotifierProvider<ItemsNotifier, CatalogItemsState>(() {
          return ItemsNotifier(catalog: widget.catalog!);
        });

  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  void dispose() {
    scrollController.dispose();
    easyRefreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          (scrollController.position.maxScrollExtent)) {
        ref.read(notifier!.notifier).queryMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.catalog == null) {
      return Container();
    }

    final items = ref.watch(notifier!);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          height: 300,
          width: MediaQuery.of(context).size.width * .8 * .8,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(5)),
          child: widget.catalog == null
              ? const SizedBox()
              : CatalogDetails(
                  catalogId: widget.catalog!.id,
                  onNewItem: (p0) {
                    ref.read(notifier!.notifier).newItem(p0);
                  },
                ),
        ),
        Expanded(child: Builder(builder: (c) {
          return switch (items) {
            AsyncValue<CatalogItemsState>(:final value?) => EasyRefresh(
                controller: easyRefreshController,
                onLoad: () {
                  ref.read(notifier!.notifier).queryMore();
                },
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: value.list.length,
                    itemBuilder: (c, index) {
                      return CatalogItemWidget(
                        item: value.list[index],
                        onRatingChange: (p0) {
                          final t = value.list[index]..score = p0;
                          ref.read(notifier!.notifier).updateItem(t);
                        },
                        onDeleteClick: (p0) {
                          ref.read(notifier!.notifier).deleteItem(p0);
                        },
                      );
                    })),
            _ => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        }))
      ],
    );
  }
}
