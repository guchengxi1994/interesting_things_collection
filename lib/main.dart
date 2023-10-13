// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:interesting_things_collection/isar/database.dart';
import 'package:interesting_things_collection/layout/desktop_layout.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends ConsumerState<MyApp> {
  var future;

  @override
  void initState() {
    super.initState();
    future = Future(() async {
      ref.read(colorNotifier).init();
      // ignore: unused_local_variable
      final IsarDatabase database = IsarDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (c, s) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
            title: 'Insteresting Things Collection',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: AppStyle.catalogCardBorderColors[
                      ref.watch(colorNotifier).currentColor]),
              useMaterial3: true,
            ),
            home: const MyHomePage(),
          );
        });
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Layout(),
    );
  }
}
