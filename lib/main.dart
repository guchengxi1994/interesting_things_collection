// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:weaving/app/run_mobile_app.dart' as m;
import 'package:weaving/app/run_desktop_app.dart' as d;
import 'package:weaving/bridge/native.dart';
import 'package:weaving/common/local_storage.dart';
import 'package:weaving/isar/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final LocalStorage _ = LocalStorage();
  // ignore: non_constant_identifier_names
  final IsarDatabase database = IsarDatabase();
  await database.initialDatabase();
  api.createEventLoop();

  if (Platform.isAndroid || Platform.isIOS) {
    m.runAPP();
  } else {
    d.runAPP();
  }
}
