import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/notifiers/catalog_notifier.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/style/app_style.dart';

typedef OnDoubleClick = VoidCallback;

class CatalogCard extends ConsumerWidget {
  const CatalogCard(
      {super.key, this.image, required this.catalog, this.onDoubleClick});
  final Widget? image;
  final Catalog catalog;
  final OnDoubleClick? onDoubleClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(catalogNotifier);

    return SizedBox(
        width: AppStyle.catalogCardWidth * AppStyle.catalogOnHoverFactor,
        height: AppStyle.catalogCardHeight * AppStyle.catalogOnHoverFactor,
        child: Center(
          child: Builder(builder: (c) {
            if (Platform.isAndroid || Platform.isIOS) {
              return _mobile();
            } else {
              return _desktop(notifier);
            }
          }),
        ));
  }

  Widget _mobile() {
    return SizedBox(
      width: AppStyle.catalogCardWidth,
      height: AppStyle.catalogCardHeight,
      child: _child(),
    );
  }

  Widget _desktop(CatalogNotifier notifier) {
    return GestureDetector(
      onDoubleTap: () {
        Future.delayed(const Duration(microseconds: 100)).then((value) {
          if (onDoubleClick != null) {
            onDoubleClick!();
          }
        });
      },
      child: MouseRegion(
        onEnter: (event) {
          notifier.changeOnHoverCatalogId(catalog.id);
        },
        onExit: (event) {
          notifier.changeOnHoverCatalogId(-1);
        },
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          width: notifier.onHoverCatalogId == catalog.id
              ? AppStyle.catalogCardWidth * AppStyle.catalogOnHoverFactor
              : AppStyle.catalogCardWidth,
          height: notifier.onHoverCatalogId == catalog.id
              ? AppStyle.catalogCardHeight * AppStyle.catalogOnHoverFactor
              : AppStyle.catalogCardHeight,
          child: _child(),
        ),
      ),
    );
  }

  Widget _child() {
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
            Expanded(flex: 2, child: _createImage(color)),
            const Divider(),
            Expanded(
                flex: 1,
                child: Text(formatDate(
                    DateTime.fromMillisecondsSinceEpoch(catalog.createdAt ?? 0)
                        .toLocal(),
                    [yyyy, '-', mm, '-', dd])))
          ],
        ),
      ),
    );
  }

  Widget _createImage(Color color) {
    if (image == null) {
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
    return image!;
  }
}
