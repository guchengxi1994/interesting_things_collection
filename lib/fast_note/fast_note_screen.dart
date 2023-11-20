import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weaving/common/sm_utils.dart';

import 'components/pin_box.dart';

class FastNoteScreen extends StatefulWidget {
  const FastNoteScreen({Key? key}) : super(key: key);

  @override
  State<FastNoteScreen> createState() => _FastNoteScreenState();
}

class _FastNoteScreenState extends State<FastNoteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (SMUtils().internalPassword == "") {
        showCupertinoDialog(
            context: context,
            builder: (c) {
              return CupertinoAlertDialog(
                title: const Text("New here?"),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(c).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
      child: Center(
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          child: const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50, left: 30, right: 30),
            child: PinputWidget(),
          ),
        ),
      ),
    );
  }
}
