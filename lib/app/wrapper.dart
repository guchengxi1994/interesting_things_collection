import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weaving/bridge/native.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key, required this.child});
  final Widget child;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final rustMessageStream = api.dartMessageStream();

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      rustMessageStream.listen((event) {
        print(event);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
