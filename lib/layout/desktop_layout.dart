import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/catalog_screen.dart';
import 'package:interesting_things_collection/layout/expand_collapse_notifier.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';

class Layout extends ConsumerWidget {
  Layout({super.key});

  late final notifier = ExpandCollapseNotifier(minWidth: 75, maxWidth: 200);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppStyle.catalogCardBorderColors[
                              ref.watch(colorNotifier).currentColor]
                          .withAlpha(200),
                      AppStyle.catalogCardBorderColors[
                              ref.watch(colorNotifier).currentColor]
                          .withAlpha(50)
                    ]),
              ),
              child: NavigationRail(
                backgroundColor: Colors.transparent,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.abc), label: Text("aaa")),
                  NavigationRailDestination(
                      icon: Icon(Icons.abc), label: Text("bbb"))
                ],
                selectedIndex: 0,
                extended: notifier.isExpanded,
                minWidth: 75,
                minExtendedWidth: 200,
              ),
            ),
            const Expanded(
                child: SizedBox.expand(
              child: CatalogScreen(),
            ))
          ],
        ),
        Positioned(
            left: notifier.currentWidth - 10,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeLeft,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final _ = notifier.changeSidemenuWidth(details);
                },
                child: Container(
                  color: Colors.transparent,
                  width: 20,
                  height: MediaQuery.of(context).size.height,
                  // child: const SizedBox.expand(),
                ),
              ),
            ))
      ],
    );
  }
}
