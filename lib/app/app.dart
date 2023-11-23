import 'package:flutter/material.dart';
import 'package:flutter_quill/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/isar/database.dart';
import 'package:weaving/layout/desktop_layout.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import '../components/fast_search_region.dart';

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
      // ignore: unused_local_variable
      final IsarDatabase database = IsarDatabase();
      LocaleSettings.setLocaleRaw(ref.read(settingsNotifier).currentLocale);
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
            title: 'Weaving',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FlutterQuillLocalizations.delegate,
            ],
            supportedLocales: FlutterQuillLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: AppStyle
                      .catalogCardBorderColors[ref.watch(colorNotifier)]),
              useMaterial3: true,
            ),
            home: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        AppStyle
                            .catalogCardBorderColors[ref.watch(colorNotifier)]
                            .withAlpha(200),
                        AppStyle
                            .catalogCardBorderColors[ref.watch(colorNotifier)]
                            .withAlpha(50)
                      ]),
                ),
                child: const Stack(
                  children: [Layout(), FastSearchRegion()],
                ),
              ),
            ),
          );
        });
  }
}
