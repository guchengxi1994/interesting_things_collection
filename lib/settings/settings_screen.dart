import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/settings/components/colors_setting.dart';
import 'package:weaving/settings/components/common_setting.dart';
import 'package:weaving/settings/components/locale_setting.dart';
import 'package:weaving/settings/settings_page_notifier.dart';

import 'components/item.dart';

const double textWidth = 200;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.watch(settingsNotifier);

    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 236, 243, 236),
                    offset: Offset(6.0, 0), //阴影y轴偏移量
                    blurRadius: 2, //阴影模糊程度
                    spreadRadius: 1 //阴影扩散程度
                    )
              ],
            ),
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: 200,
            child: Column(
              children: [
                t.settings.column.color,
                t.settings.column.common,
                t.settings.column.language
              ].mapIndexed((index, element) => Item(index, element)).toList(),
            ),
          ),
          Expanded(
              child: PageView(
            controller:
                ref.read(settingsPageController.notifier).pageController,
            children: const [
              ColorsSettingWidget(),
              CommonSettingWidget(),
              LocaleSettingWidget()
            ],
          ))
        ],
      ),
    );
  }
}
