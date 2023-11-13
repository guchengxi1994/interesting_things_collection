import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:interesting_things_collection/isar/database.dart';
import 'package:interesting_things_collection/layout/desktop_layout.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends ConsumerState<MyApp> {
  // ignore: prefer_typing_uninitialized_variables
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
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FlutterQuillLocalizations.delegate,
            ],
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: AppStyle.catalogCardBorderColors[
                      ref.watch(colorNotifier).currentColor]),
              useMaterial3: true,
            ),
            home: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppStyle.catalogCardBorderColors[
                                ref.watch(colorNotifier).currentColor]
                            .withAlpha(200),
                        AppStyle.catalogCardBorderColors[
                                ref.watch(colorNotifier).currentColor]
                            .withAlpha(50)
                      ]),
                ),
                child: const Layout(),
              ),
            ),
          );
        });
  }
}
