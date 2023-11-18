import 'dart:io';

void main() async {
  // 创建 UDP 客户端
  RawDatagramSocket.bind(InternetAddress.loopbackIPv4, 0)
      .then((RawDatagramSocket socket) {
    print('UDP 客户端已启动');
    socket.send('Hello, UDP'.codeUnits, InternetAddress.loopbackIPv4, 15234);
  });
}
