import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:interesting_things_collection/isar/database.dart';
import 'package:interesting_things_collection/layout/desktop_layout.dart';

import 'catalog/catalog_notifier.dart';
import 'common/dev_tool.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      title: 'Insteresting Things Collection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final IsarDatabase database = IsarDatabase();

  Future _incrementCounter(WidgetRef ref) async {
    await ref.read(catalogNotifier).newCatalog(DevTool.getRandomString(5));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        while (database.isar == null) {
          await Future.delayed(const Duration(milliseconds: 200));
        }
        ref.read(catalogNotifier).queryAll();
      },
    );

    return Scaffold(
      body: Layout(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter(ref).then((value) {
            ref.read(catalogNotifier).queryAll();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
