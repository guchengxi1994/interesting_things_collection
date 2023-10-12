import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/catalog_notifier.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/style/app_style.dart';

class CatalogCard extends ConsumerWidget {
  const CatalogCard({super.key, this.image, required this.catalog});
  final Widget? image;
  final Catalog catalog;

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
    return MouseRegion(
      onEnter: (event) {
        notifier.changeOnHoverCatalogId(catalog.id);
      },
      onExit: (event) {
        notifier.changeOnHoverCatalogId(-1);
      },
      child: SizedBox(
        width: notifier.onHoverCatalogId == catalog.id
            ? AppStyle.catalogCardWidth * AppStyle.catalogOnHoverFactor
            : AppStyle.catalogCardWidth,
        height: notifier.onHoverCatalogId == catalog.id
            ? AppStyle.catalogCardHeight * AppStyle.catalogOnHoverFactor
            : AppStyle.catalogCardHeight,
        child: _child(),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: Colors.transparent,
          onTap: () {},
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: image ??
                      SizedBox(
                        child: Center(
                          child: Text(catalog.orderNum.toString()),
                        ),
                      )),
              const Divider(),
              Expanded(flex: 1, child: Text("${catalog.name}:${catalog.id}"))
            ],
          ),
        ),
      ),
    );
  }
}
