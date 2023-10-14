import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:collection/collection.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Color Theme"),
            const SizedBox(
              height: 10,
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
