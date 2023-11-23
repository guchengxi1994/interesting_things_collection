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
                    value:
                        ref.watch(settingsNotifier).showPreviewWhenHoverOnItems,
                    onChanged: (v) {
                      ref
                          .read(settingsNotifier.notifier)
                          .changeShowPreviewWhenHoverOnItems(v);
                    }),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  child: Text("Enable unlock password"),
                ),
                Switch(
                    value: ref.watch(settingsNotifier).enableUnlockPwd,
                    onChanged: (v) {
                      ref.read(settingsNotifier.notifier).changeEnablePwd(v);
                    }),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  child: Text("Verify when operating catalogs"),
                ),
                Switch(value: false, onChanged: (v) {}),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  child: Text("Verify when operating catalog items"),
                ),
                Switch(value: false, onChanged: (v) {}),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  child: Text("Verify when operating fast notes"),
                ),
                Switch(value: false, onChanged: (v) {}),
              ],
            ),
          ]),
    );
  }
}
