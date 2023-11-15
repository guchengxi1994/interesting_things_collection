import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/models/things_state.dart';
import 'package:interesting_things_collection/catalog/notifiers/things_notifier.dart';
import 'package:interesting_things_collection/isar/catalog.dart';

import 'thing_widget.dart';

class CatalogThingsWidget extends ConsumerStatefulWidget {
  const CatalogThingsWidget({super.key, required this.catalog});
  final Catalog? catalog;

  @override
  ConsumerState<CatalogThingsWidget> createState() =>
      _CatalogThingsWidgetState();
}

class _CatalogThingsWidgetState extends ConsumerState<CatalogThingsWidget> {
  late final notifier = widget.catalog == null
      ? null
      : AsyncNotifierProvider<ThingsNotifier, ThingsState>(() {
          return ThingsNotifier(catalog: widget.catalog!);
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

    final things = ref.watch(notifier!);

    return Builder(builder: (c) {
      return switch (things) {
        AsyncValue<ThingsState>(:final value?) => EasyRefresh(
            controller: easyRefreshController,
            onLoad: () {
              ref.read(notifier!.notifier).queryMore();
            },
            child: ListView.builder(
                controller: scrollController,
                itemCount: value.thingsList.length,
                itemBuilder: (c, index) {
                  // return SizedBox(
                  //   height: 200,
                  //   child: Text(value.thingsList[index].name.toString()),
                  // );
                  return ThingWidget(
                    thing: value.thingsList[index],
                  );
                })),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    });
  }
}
