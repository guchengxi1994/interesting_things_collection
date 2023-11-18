import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/settings/settings_page_notifier.dart';
import 'package:weaving/style/app_style.dart';

class Item extends ConsumerWidget {
  const Item(this.index, this.name, {super.key});
  final int index;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = index == ref.watch(settingsPageController).$1;
    final b2 = index == ref.watch(settingsPageController).$2;

    return InkWell(
      onTap: () {
        ref.read(settingsPageController.notifier).changePageIndex(index);
      },
      child: MouseRegion(
        onEnter: (event) {
          ref.read(settingsPageController.notifier).changeHoverIndex(index);
        },
        onExit: (event) {
          ref.read(settingsPageController.notifier).changeHoverIndex(-1);
        },
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: b
                  ? AppStyle.catalogCardBorderColors[ref.watch(colorNotifier)]
                      .withAlpha(200)
                  : b2
                      ? AppStyle
                          .catalogCardBorderColors[ref.watch(colorNotifier)]
                          .withAlpha(50)
                      : Colors.transparent),
          width: 200,
          height: 30,
          child: Text(
            name,
            style: TextStyle(
                color: b ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: b ? FontWeight.bold : null),
          ),
        ),
      ),
    );
  }
}
