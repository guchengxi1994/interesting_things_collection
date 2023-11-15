import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';

typedef OnSave = void Function(String);

class AddTagButton extends ConsumerStatefulWidget {
  const AddTagButton({super.key, required this.onSave});
  final OnSave onSave;

  @override
  ConsumerState<AddTagButton> createState() => _AddTagButtonState();
}

const double size = 20;

class _AddTagButtonState extends ConsumerState<AddTagButton> {
  bool isActivate = false;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppStyle
              .catalogCardBorderColors[ref.read(colorNotifier).currentColor]),
      child: FittedBox(
        child: !isActivate
            ? InkWell(
                onTap: () {
                  setState(() {
                    isActivate = !isActivate;
                  });
                },
                child: const Icon(
                  Icons.add,
                  size: size,
                ),
              )
            : SizedBox(
                width: 300,
                height: size,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller,
                      maxLength: 20,
                      style: const TextStyle(fontSize: 12),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          counterText: "",
                          hintStyle: const TextStyle(fontSize: 12),
                          hintText: "Max length 20",
                          fillColor: AppStyle.inputFillColor,
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 18),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppStyle.catalogCardBorderColors[
                                    ref.read(colorNotifier).currentColor]),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                          )),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.check,
                        size: size,
                      ),
                      onTap: () {
                        setState(() {
                          widget.onSave(controller.text);
                          isActivate = !isActivate;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: const Icon(
                        Icons.refresh,
                        size: size,
                      ),
                      onTap: () {
                        controller.text = "";
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
