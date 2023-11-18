import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/style/app_style.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:collection/collection.dart';

class ColorsSettingWidget extends ConsumerWidget {
  const ColorsSettingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(t.settings.colorTheme),
              ),
              FittedBox(
                child: Row(
                  children: AppStyle.catalogCardBorderColors
                      .mapIndexed((i, e) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 30,
                            height: 30,
                            color: e,
                            child: InkWell(
                              onTap: () {
                                ref.read(colorNotifier.notifier).changeColor(i);
                              },
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
