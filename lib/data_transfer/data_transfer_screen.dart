import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/data_transfer/udp_server.dart';

class DataTransferScreen extends ConsumerStatefulWidget {
  const DataTransferScreen({super.key});

  @override
  ConsumerState<DataTransferScreen> createState() => _DataTransferScreenState();
}

class _DataTransferScreenState extends ConsumerState<DataTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              UdpServer.instance.startUdpServer();
            },
            child: const Text("server")),
      ),
    );
  }
}
