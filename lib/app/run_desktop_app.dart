import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/app/app.dart';
import 'package:window_manager/window_manager.dart';

void runAPP() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  windowManager.waitUntilReadyToShow(null, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  windowManager.setBackgroundColor(Colors.transparent);
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
