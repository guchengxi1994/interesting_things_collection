import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/style/app_style.dart';

typedef OnSave = void Function(String s);
typedef OnAdd = void Function(String s);

class CustomEditableText extends ConsumerStatefulWidget {
  const CustomEditableText(
      {Key? key,
      required this.value,
      required this.onDelete,
      required this.onSave,
      required this.onAdd,
      this.isEditing = false})
      : super(key: key);
  final String value;
  final OnSave onSave;
  final VoidCallback onDelete;
  final OnAdd onAdd;
  final bool isEditing;

  @override
  ConsumerState<CustomEditableText> createState() => _CustomEditableTextState();
}

class _CustomEditableTextState extends ConsumerState<CustomEditableText> {
  late final TextEditingController controller = TextEditingController()
    ..text = widget.value == "请输入" ? "" : widget.value;
  late bool isEditing = widget.isEditing;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "请输入",
                        counterText: "",
                        fillColor: AppStyle.inputFillColor,
                        filled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppStyle.catalogCardBorderColors[
                                  ref.read(colorNotifier)]),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        )),
                  )
                : Text(
                    controller.text,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )),
        const SizedBox(
          width: 10,
        ),
        Tooltip(
          message: "修改",
          child: InkWell(
            onTap: () {
              if (isEditing) {
                widget.onSave(controller.text);
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
            child: isEditing
                ? const Icon(Icons.check, color: Colors.green)
                : const Icon(
                    Icons.change_circle,
                    color: AppStyle.titleTextColor,
                  ),
          ),
        ),
        Tooltip(
          message: "复制值",
          child: InkWell(
            onTap: isEditing
                ? null
                : () async {
                    final item = DataWriterItem();
                    item.add(Formats.plainText(controller.text));
                    await ClipboardWriter.instance.write([item]);
                  },
            child: const Icon(
              Icons.copy,
              color: AppStyle.titleTextColor,
            ),
          ),
        ),
        Tooltip(
          message: "删除",
          child: InkWell(
            onTap: () {
              widget.onDelete();
            },
            child: const Icon(
              Icons.delete,
              color: AppStyle.titleTextColor,
            ),
          ),
        ),
        Tooltip(
          message: "加密",
          child: InkWell(
            onTap: () {
              widget.onDelete();
            },
            child: const Icon(
              Icons.lock,
              color: AppStyle.titleTextColor,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
