import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/settings_notifier.dart';

class CommonSettingWidget extends ConsumerWidget {
  const CommonSettingWidget({super.key});

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
          ]),
    );
  }
}
