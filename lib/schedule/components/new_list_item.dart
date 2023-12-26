import 'package:flutter/material.dart';

import 'package:weaving/style/app_style.dart';

typedef OnCreate = void Function(String);

/// flutter bug https://github.com/flutter/flutter/issues/124421
class NewListItem extends StatefulWidget {
  const NewListItem({
    super.key,
    required this.onCreate,
  });

  final OnCreate onCreate;

  @override
  State<NewListItem> createState() => _NewListItemState();
}

class _NewListItemState extends State<NewListItem> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(border: Border.all()),
      padding: const EdgeInsets.all(15),
      height: AppStyle.kanbanItemHeight,
      child: Center(
        child: TextField(
          onSubmitted: (value) {
            // print(value);

            widget.onCreate(value);
          },
          autofocus: true,
          controller: controller,
          maxLines: 1,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              hintText: "请输入",
              counterText: "",
              fillColor: AppStyle.inputFillColor,
              filled: true,
              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              )),
        ),
      ),
    );
  }
}
