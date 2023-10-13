import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCatalogDialog extends ConsumerStatefulWidget {
  const AddCatalogDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AddCatalogDialogState();
  }
}

class AddCatalogDialogState extends ConsumerState<AddCatalogDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 0.8 * MediaQuery.of(context).size.width,
      height: 0.8 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close),
              )
            ],
          ),
          const Expanded(
              child: SingleChildScrollView(
            child: Column(),
          ))
        ],
      ),
    );
  }
}
