import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/settings_notifier.dart';

class LocaleSettingWidget extends ConsumerWidget {
  const LocaleSettingWidget({super.key});

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
    );
  }
}
