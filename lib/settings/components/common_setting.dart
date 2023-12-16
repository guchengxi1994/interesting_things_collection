import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsb_dart/bridge_definitions.dart';
import 'package:weaving/bridge/native.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';

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
                CupertinoSwitch(
                    activeColor: AppStyle
                        .catalogCardBorderColors[ref.watch(colorNotifier)],
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
                SizedBox(
                  width: 200,
                  child: Text(t.settings.enablePassword),
                ),
                CupertinoSwitch(
                    activeColor: AppStyle
                        .catalogCardBorderColors[ref.watch(colorNotifier)],
                    value: ref.watch(settingsNotifier).enableUnlockPwd,
                    onChanged: (v) {
                      ref.read(settingsNotifier.notifier).changeEnablePwd(v);
                    }),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(t.settings.operateCatalog),
                ),
                CupertinoSwitch(
                    activeColor: AppStyle
                        .catalogCardBorderColors[ref.watch(colorNotifier)],
                    value: false,
                    onChanged: (v) {}),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(t.settings.operateCatalogItems),
                ),
                CupertinoSwitch(
                    activeColor: AppStyle
                        .catalogCardBorderColors[ref.watch(colorNotifier)],
                    value: false,
                    onChanged: (v) {}),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(t.settings.operateFastNote),
                ),
                CupertinoSwitch(
                    activeColor: AppStyle
                        .catalogCardBorderColors[ref.watch(colorNotifier)],
                    value: false,
                    onChanged: (v) {}),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  api.showDialog(
                      message: const EventMessage(
                          title: "a ba a ba",
                          content: "a ba a ba",
                          alignment: (0, 0),
                          dialogType: DialogType.notification));
                },
                child: Text("test")),
            ElevatedButton(
                onPressed: () {
                  api.sendDartMessage(message: "aaaaa");
                },
                child: Text("send message")),
            ElevatedButton(
                onPressed: () {
                  api.sendDartMessage(message: "bbbbb");
                },
                child: Text("send message"))
          ]),
    );
  }
}
