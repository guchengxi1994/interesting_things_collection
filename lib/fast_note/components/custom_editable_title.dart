import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/style/app_style.dart';

typedef OnSave = void Function(String s);

class CustomEditableTitle extends ConsumerStatefulWidget {
  const CustomEditableTitle({
    super.key,
    required this.title,
    required this.onSave,
  });
  final String title;
  final OnSave onSave;

  @override
  ConsumerState<CustomEditableTitle> createState() =>
      _CustomEditableTitleState();
}

class _CustomEditableTitleState extends ConsumerState<CustomEditableTitle> {
  late final TextEditingController controller = TextEditingController()
    ..text = widget.title;

  late bool isEditing = widget.title == "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isEditing
            ? SizedBox(
                width: 300,
                child: TextField(
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
                ),
              )
            : Text(
                controller.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppStyle.titleTextColor),
              ),
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
                    Icons.edit,
                    color: AppStyle.titleTextColor,
                  ),
          ),
        ),
      ],
    );
  }
}
