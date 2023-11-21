import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

import 'data_transfer_model.dart';

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
    if (_isolate != null) {
      return;
    }
    //创建一个ReceivePort
    final receivePort1 = ReceivePort();

    _isolate = await Isolate.spawn(_udpServer, receivePort1.sendPort);
  }

  stopServer() {
    if (_isolate != null) {
      _isolate!.kill(priority: 0);
      _isolate = null;
    }
  }

  void _udpServer(SendPort sendPort1) async {
    List<DataTransferModel> datas = [];

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 15234)
        .then((RawDatagramSocket socket) {
      if (kDebugMode) {
        print('UDP 服务器已启动');
      }
      socket.listen((RawSocketEvent e) {
        Datagram? d = socket.receive();
        if (d == null) return;

        String message = const Utf8Decoder().convert(d.data).trim();

        try {
          DataTransferModel model =
              DataTransferModel.fromJson(jsonDecode(message));

          if (model.count == 1) {
            // 处理单个分片逻辑
          } else {
            datas.add(model);
            // 最后一个分片, 这里先不考虑并发情况

            /// TODO 并发的话需要每一次获取到数据都判断切片数量是不是对的
            /// 然后合并
            if (model.id == model.count! - 1) {
              List<DataTransferModel> d0 = datas.getByUUID(model.uuid!);
              String? s = d0.restore();
              // print(s);

              datas.retainWhere((element) => element.uuid != model.uuid);
            }
          }
        } catch (_) {}
      });
    });
  }
}
