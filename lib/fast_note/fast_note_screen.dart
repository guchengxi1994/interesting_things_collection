import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastNoteScreen extends StatefulWidget {
  const FastNoteScreen({Key? key}) : super(key: key);

  @override
  State<FastNoteScreen> createState() => _FastNoteScreenState();
}

class _FastNoteScreenState extends State<FastNoteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
    );
  }
}
