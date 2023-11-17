// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weaving/app/run_mobile_app.dart' as m;
import 'package:weaving/app/run_desktop_app.dart' as d;
import 'package:weaving/common/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalStorage _ = LocalStorage();

  if (Platform.isAndroid || Platform.isIOS) {
    m.runAPP();
  } else {
    d.runAPP();
  }
}
