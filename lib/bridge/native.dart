import 'dart:ffi';

import 'package:fsb_dart/bridge_generated.dart';
export 'package:fsb_dart/bridge_generated.dart';
// export 'package:fsb_dart/bridge_definitions.dart';

import 'dart:io' as io;

const _base = 'fsb';

// On MacOS, the dynamic library is not bundled with the binary,
// but rather directly **linked** against the binary.
final _dylib = io.Platform.isWindows ? '$_base.dll' : 'lib$_base.so';

final api = FsbImpl(io.Platform.isIOS || io.Platform.isMacOS
    ? DynamicLibrary.executable()
    : DynamicLibrary.open(_dylib));
