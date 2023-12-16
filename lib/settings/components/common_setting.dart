import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fsb_dart/bridge_definitions.dart';
import 'package:weaving/bridge/native.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';

class CommonSettingWidget extends ConsumerStatefulWidget {
  const CommonSettingWidget({super.key});

  @override
  ConsumerState<CommonSettingWidget> createState() =>
      _CommonSettingWidgetState();
}

class _CommonSettingWidgetState extends ConsumerState<CommonSettingWidget> {
  late final Stream<String> stream = api.dartMessageStream();

  @override
  void initState() {
    super.initState();
    stream.listen((event) {
      SmartDialog.showToast(event);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          content: "居中",
                          alignment: (0, 0),
                          dialogType: DialogType.notification));
                },
                child: Text("居中通知")),
            ElevatedButton(
                onPressed: () {
                  api.showDialog(
                      message: const EventMessage(
                          title: "a ba a ba",
                          content: "右下",
                          alignment: (1, 1),
                          dialogType: DialogType.notification));
                },
                child: Text("右下通知")),
            ElevatedButton(
                onPressed: () {
                  api.showDialog(
                      message: const EventMessage(
                          title: "a ba a ba",
                          content: "左上",
                          alignment: (-1, -1),
                          dialogType: DialogType.notification));
                },
                child: Text("左上通知")),
            ElevatedButton(
                onPressed: () {
                  api.showDialog(
                      message: const EventMessage(
                          title: "Dialog",
                          content: "确认否？",
                          alignment: (0, 0),
                          dialogType: DialogType.confirmDialog));
                },
                child: Text("确认弹窗")),
            ElevatedButton(
                onPressed: () {
                  api.showDialog(
                      message: const EventMessage(
                          title: "Dialog",
                          content: "确认否？",
                          alignment: (0, 0),
                          dialogType: DialogType.warningDialog));
                },
                child: Text("操作")),
          ]),
    );
  }
}
