import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/bridge/native.dart';
import 'package:weaving/common/logger.dart';
import 'package:weaving/schedule/notifiers/board_notifier.dart';

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
              ref.read(kanbanBoardNotifier).value!.kanbanData.first,
              j['data']['title']);
          api.setItemId(id: i);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(kanbanBoardNotifier);
    return widget.child;
  }
}
