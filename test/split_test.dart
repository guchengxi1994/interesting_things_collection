void main() {
  final re = RegExp(r'测试|ppp|gg');

  const String s = "这是一条测试数据，测试内容包括“ppp”和“gg”";

  List<String> parts = s.split(re);

  // ignore: avoid_print
  print(parts);
}
