import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/catalog/models/things_state.dart';
import 'package:weaving/catalog/notifiers/things_notifier.dart';
import 'package:weaving/isar/catalog.dart';

import 'catalog_details.dart';
import 'thing_widget.dart';

class CatalogThingsWidget extends ConsumerStatefulWidget {
  const CatalogThingsWidget({super.key, required this.catalog});
  final CatalogCopy? catalog;

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
                  onNewThing: (p0) {
                    ref.read(notifier!.notifier).newThing(p0);
                  },
                ),
        ),
        Expanded(child: Builder(builder: (c) {
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
                        onRatingChange: (p0) {
                          final t = value.thingsList[index]..score = p0;
                          ref.read(notifier!.notifier).updateThing(t);
                        },
                        onDeleteClick: (p0) {
                          ref.read(notifier!.notifier).deleteThing(p0);
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
