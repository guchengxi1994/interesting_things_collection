import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/bridge/native.dart';
import 'package:weaving/common/logger.dart';
import 'package:weaving/layout/navigator.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';
import 'package:window_manager/window_manager.dart';

class AppWrapper extends ConsumerStatefulWidget {
  const AppWrapper({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends ConsumerState<AppWrapper> {
  final rustMessageStream = api.dartMessageStream();

  @override
  void initState() {
    super.initState();

    if (Platform.isWindows) {
      rustMessageStream.listen((event) async {
        logger.info(event);
        final j = jsonDecode(event);
        if (j['data']['type'] == 1) {
          final i = await ref.read(kanbanBoardNotifier.notifier).newItem(
              ref
                  .read(kanbanBoardNotifier)
                  .value!
                  .kanbanData
                  .where((element) => element.name == "In progress")
                  .first,
              j['data']['title']);
          api.setItemId(id: i);
        } else if (j['data']['type'] == 2) {
          ref
              .read(kanbanBoardNotifier.notifier)
              .changeStatus(int.parse(j['data']['title']));
        } else if (j['data']['type'] == 3) {
          if (!await windowManager.isFocused()) {
            windowManager.focus();
          }
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      while (ref.read(kanbanBoardNotifier).value == null) {
        await Future.delayed(const Duration(milliseconds: 200));
      }

      if (ref
          .read(kanbanBoardNotifier)
          .value!
          .kanbanData
          .where((element) => element.name == "In progress")
          .first
          .items
          .isNotEmpty) {
        //
        // ignore: use_build_context_synchronously
        showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierColor: Colors.grey.withOpacity(0.7),
            barrierLabel: "b",
            pageBuilder: (c, _, __) {
              return Center(
                child: Container(
                  height: 120,
                  width: 350,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You have something to handle",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          ElevatedButton(
                              onPressed: () {
                                // PageNavigator.controller.jumpToPage(2);
                                ref.read(pageNavigator.notifier).changeState(2);
                              },
                              child: const Text("Navigate"))
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(kanbanBoardNotifier);
    return widget.child;
  }
}
