// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:weaving/data_transfer/data_transfer_model.dart';

void main() async {
  final r = await InternetAddress.lookup("192.168.43.54");
  File f = File(r"d:\Desktop\1.txt");
  String fstr = f.readAsStringSync();

  // 创建 UDP 客户端
  RawDatagramSocket.bind(r.first, 0).then((RawDatagramSocket socket) async {
    print('UDP 客户端已启动');

    // final d = utf8.encode("中文测试");
    // // print(base64.encode(d));

    socket.send(utf8.encode("aaaaaaaaa"), r.first, 15234);

    try {
      List<DataTransferModel> models = splitToTransferModel(fstr);

      for (final i in models) {
        print(jsonEncode(i.toJson()));
        socket.send(utf8.encode(jsonEncode(i.toJson())), r.first, 15234);
      }

      print("done");
    } catch (e) {
      print(e);
    }
  });
}
