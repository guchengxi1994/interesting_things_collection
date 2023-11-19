// ignore_for_file: avoid_print

import 'dart:io';

main() async {
  final ipv4 = InternetAddress.loopbackIPv4;
  print(ipv4.address);
  print(ipv4.host);

  final host = await InternetAddress.lookup('google.com');
  print(host);

  final interfaces = await NetworkInterface.list();
  for (var interface in interfaces) {
    print('Interface: ${interface.name}');
    for (var address in interface.addresses) {
      print('IP Address: ${address.address}');
    }
  }
}
