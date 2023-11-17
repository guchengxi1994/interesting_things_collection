import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:weaving/gen/strings.g.dart';

const double textWidth = 200;

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
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
                                  ref.read(colorNotifier).changeColor(i);
                                },
                              ),
                            ))
                        .toList(),
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(t.settings.showPreview),
                ),
                Switch(
                    value: ref
                        .watch(settingsNotifier)
                        .showPreviewWhenHoverOnThings,
                    onChanged: (v) {
                      ref
                          .read(settingsNotifier.notifier)
                          .changeShowPreviewWhenHoverOnThings(v);
                    }),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(t.settings.locale),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: ref
                        .watch(settingsNotifier)
                        .supportLocales
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: ref.watch(settingsNotifier).currentLocale,
                    onChanged: (String? value) {
                      // print(value);
                      if (value != null) {
                        ref
                            .read(settingsNotifier.notifier)
                            .changeCurrentLocale(value);
                      }
                    },
                    buttonStyleData: ButtonStyleData(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: const Color.fromARGB(255, 217, 211, 211)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
