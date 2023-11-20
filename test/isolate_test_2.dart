// ignore_for_file: avoid_print

import 'dart:isolate';

void main() async {
  // 创建 ReceivePort 以接收消息
  ReceivePort receivePort = ReceivePort();

  // 启动新的 Isolate，并将 sendPort 传递给它
  await Isolate.spawn(dataHandler, receivePort.sendPort);

  // 新的 Isolate 给我们的 sendPort 发送了一个消息，这个消息是它自己的 SendPort
  SendPort newIsolateSendPort = await receivePort.first;

  // 我们可以使用这个 sendPort 给新的 Isolate 发送消息
  newIsolateSendPort.send(["Hi", receivePort.sendPort]);
}

// 新的 Isolate 的入口函数
void dataHandler(SendPort sendPort) {
  // 创建一个 ReceivePort 以接收消息
  ReceivePort port = ReceivePort();

  // 把它的 sendPort 发送给它的父 Isolate，以便父 Isolate 可以给它发送消息
  sendPort.send(port.sendPort);

  // 监听消息
  port.listen((message) {
    print(message[0]);
    SendPort replyTo = message[1];
    replyTo.send("Message received");
  });
}
