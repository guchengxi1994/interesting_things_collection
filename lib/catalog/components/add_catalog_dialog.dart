import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/catalog_notifier.dart';
import 'package:interesting_things_collection/isar/catalog.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';

class AddCatalogDialog extends ConsumerStatefulWidget {
  const AddCatalogDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AddCatalogDialogState();
  }
}

class AddCatalogDialogState extends ConsumerState<AddCatalogDialog> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        width: 0.8 * MediaQuery.of(context).size.width,
        height: 0.8 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          const SizedBox(
            height: 10,
          ),
          _catalogName(),
          const SizedBox(
            height: 10,
          ),
        ]));
  }

  Widget _catalogName() {
    return Row(
      children: [
        const SizedBox(
          width: 100,
          child: Text("Catalog Name"),
        ),
        Expanded(
            child: Autocomplete(
          optionsViewBuilder: _buildOptionsView,
          optionsBuilder: _buildOptions,
          onSelected: (catalog) {
            _focusNode.unfocus(); //输入框失去焦点，收起键盘
          },
          fieldViewBuilder: (c, controller, focusNode, onSubmit) {
            _textEditingController = controller;
            _focusNode = focusNode;
            return TextFormField(
              controller: _textEditingController,
              focusNode: _focusNode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  fillColor: AppStyle.inputFillColor,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
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
            );
          },
        ))
      ],
    );
  }

  Future<Iterable<Catalog>> _buildOptions(
      TextEditingValue textEditingValue) async {
    if (textEditingValue.text == '') {
      return const Iterable<Catalog>.empty();
    }
    return ref
        .read(catalogNotifier)
        .datas
        .where((element) => element.name!.contains(textEditingValue.text));
  }

  Widget _buildOptionsView(BuildContext context,
      AutocompleteOnSelected<Catalog> onSelected, Iterable<Catalog> options) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Material(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 150.0, maxWidth: 400),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: AppStyle.catalogCardBorderColors[
                        ref.read(colorNotifier).currentColor])),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemBuilder: (_, index) {
                final Catalog option = options.elementAt(index);
                return InkWell(
                  onTap: () {
                    _textEditingController.text = option.name!;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10),
                    child: Text.rich(
                        _formSpan(option.name!, _textEditingController.text)),
                  ),
                );
              },
              itemCount: options.length,
            ),
          ),
        ),
      ),
    );
  }

  ///高亮某些文字
  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );
  InlineSpan _formSpan(String src, String pattern) {
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        span.add(TextSpan(text: parts[i]));
        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: lightTextStyle));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }
}
