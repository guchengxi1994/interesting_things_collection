import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

class UdpServer {
  static UdpServer? _instance;
  UdpServer._internal();

  static UdpServer get instance {
    _instance ??= UdpServer._internal();
    return _instance!;
  }

  // ignore: avoid_init_to_null, unused_field
  Isolate? _isolate = null;

  Future startUdpServer() async {
    //创建一个ReceivePort
    final receivePort1 = ReceivePort();

    _isolate = await Isolate.spawn(_udpServer, receivePort1.sendPort);
  }

  void _udpServer(SendPort sendPort1) async {
    RawDatagramSocket.bind(InternetAddress.loopbackIPv4, 15234)
        .then((RawDatagramSocket socket) {
      if (kDebugMode) {
        print('UDP 服务器已启动');
      }
      socket.listen((RawSocketEvent e) {
        Datagram? d = socket.receive();
        if (d == null) return;

        String message = String.fromCharCodes(d.data).trim();
        if (kDebugMode) {
          print('接收到: $message');
        }
      });
    });
  }
}
