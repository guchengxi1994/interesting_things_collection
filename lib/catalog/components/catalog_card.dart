import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/notifiers/catalog_notifier.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/style/app_style.dart';

typedef OnDoubleClick = VoidCallback;

class CatalogCard extends ConsumerStatefulWidget {
  const CatalogCard(
      {super.key, this.image, required this.catalogId, this.onDoubleClick});
  final Widget? image;
  final int catalogId;
  final OnDoubleClick? onDoubleClick;

  @override
  ConsumerState<CatalogCard> createState() => _CatalogCardState();
}

class _CatalogCardState extends ConsumerState<CatalogCard> {
  // ignore: prefer_typing_uninitialized_variables
  var future;
  // ignore: avoid_init_to_null
  late Catalog? catalog = null;

  @override
  void initState() {
    super.initState();
    future = Future(() async {
      catalog =
          await ref.read(catalogNotifier).getCatalogById(widget.catalogId);
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant CatalogCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.microtask(() async {
      final newCatalog =
          await ref.read(catalogNotifier).getCatalogById(widget.catalogId);
      if (newCatalog != catalog) {
        setState(() {
          catalog = newCatalog;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppStyle.catalogCardWidth * AppStyle.catalogOnHoverFactor,
        height: AppStyle.catalogCardHeight * AppStyle.catalogOnHoverFactor,
        child: FutureBuilder<void>(
            future: future,
            builder: (c, s) {
              if (s.connectionState == ConnectionState.done) {
                return Center(
                  child: Builder(builder: (c) {
                    if (Platform.isAndroid || Platform.isIOS) {
                      return _mobile(catalog!);
                    } else {
                      return _desktop(catalog!);
                    }
                  }),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget _mobile(Catalog catalog) {
    return SizedBox(
      width: AppStyle.catalogCardWidth,
      height: AppStyle.catalogCardHeight,
      child: _child(catalog),
    );
  }

  Widget _desktop(Catalog catalog) {
    return GestureDetector(
      onDoubleTap: () {
        Future.delayed(const Duration(microseconds: 100)).then((value) {
          if (widget.onDoubleClick != null) {
            widget.onDoubleClick!();
          }
        });
      },
      child: MouseRegion(
        onEnter: (event) {
          ref.read(catalogNotifier).changeOnHoverCatalogId(catalog.id);
        },
        onExit: (event) {
          ref.read(catalogNotifier).changeOnHoverCatalogId(-1);
        },
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          width: ref.watch(catalogNotifier).onHoverCatalogId == catalog.id
              ? AppStyle.catalogCardWidth * AppStyle.catalogOnHoverFactor
              : AppStyle.catalogCardWidth,
          height: ref.watch(catalogNotifier).onHoverCatalogId == catalog.id
              ? AppStyle.catalogCardHeight * AppStyle.catalogOnHoverFactor
              : AppStyle.catalogCardHeight,
          child: _child(catalog),
        ),
      ),
    );
  }

  Widget _child(Catalog catalog) {
    final color = AppStyle.catalogCardBorderColors[catalog.name.hashCode % 8];

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 10,
              spreadRadius: 2.5,
            ),
            const BoxShadow(
              color: Color(0xFFE8E8E8),
              blurRadius: 10,
              spreadRadius: 2.5,
            )
          ],
          border: Border.all(color: color)),
      // padding: const EdgeInsets.all(2.5),
      child: SizedBox(
        child: Column(
          children: [
            Expanded(flex: 2, child: _createImage(color, catalog)),
            const Divider(),
            Expanded(flex: 1, child: Text("${catalog.tags?.length} tags"))
          ],
        ),
      ),
    );
  }

  Widget _createImage(Color color, Catalog catalog) {
    if (widget.image == null) {
      var s = "";
      if (catalog.name!.length >= 2) {
        s = catalog.name!.substring(0, 2).toUpperCase();
      } else {
        s = catalog.name![0].toUpperCase();
      }

      return Center(
        child: Text(
          s,
          style: TextStyle(fontSize: 25, color: color),
        ),
      );
    }
    return widget.image!;
  }
}
