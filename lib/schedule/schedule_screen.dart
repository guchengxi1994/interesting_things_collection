import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/style/app_style.dart';

import 'components/board.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: AppStyle.leftTopRadius),
      child: const CustomBoard(),
    );
  }
}
