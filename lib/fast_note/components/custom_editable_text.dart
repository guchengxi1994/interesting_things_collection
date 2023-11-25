import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/style/app_style.dart';

typedef OnSave = void Function(String s);

class CustomEditableText extends ConsumerStatefulWidget {
  const CustomEditableText(
      {Key? key,
      required this.value,
      required this.onDelete,
      required this.onSave})
      : super(key: key);
  final String value;
  final OnSave onSave;
  final VoidCallback onDelete;

  @override
  ConsumerState<CustomEditableText> createState() => _CustomEditableTextState();
}

class _CustomEditableTextState extends ConsumerState<CustomEditableText> {
  late final TextEditingController controller = TextEditingController()
    ..text = widget.value;
  bool isEditing = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
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
        InkWell(
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
        InkWell(
          onTap: () {
            widget.onDelete();
          },
          child: const Icon(
            Icons.delete,
            color: AppStyle.titleTextColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
