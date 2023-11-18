import 'dart:isolate';

void main() async {
  // 1. 创建管道
  ReceivePort receivePort = ReceivePort();

  // 2. 创建新的 Isolate
  Isolate isolate = await Isolate.spawn<SendPort>(foo, receivePort.sendPort);

  // 3. 监听管道消息
  receivePort.listen((data) {
    print('Data：$data');
    // 不再使用时，我们会关闭管道
    receivePort.close();
    // 需要将 isolate 杀死
    isolate.kill(priority: Isolate.immediate);
  });
}

void foo(SendPort sendPort) {
  sendPort.send("Hello World");
}
