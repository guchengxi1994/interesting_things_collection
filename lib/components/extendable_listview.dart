import 'package:flutter/material.dart';
import 'package:weaving/style/app_style.dart';

typedef DataProvider = List<String> Function();
typedef DataItem = Widget Function(String);
typedef OnItemSelected = void Function(String);
typedef OnItemCreated = void Function(String);
typedef OnItemDeleted = void Function(String);

class ExtendableListView<T> extends StatefulWidget {
  const ExtendableListView(
      {super.key,
      required this.dataItem,
      required this.dataProvider,
      required this.onItemCreated,
      required this.onItemDeleted,
      required this.onItemSelected});
  final DataProvider dataProvider;
  final DataItem dataItem;
  final OnItemCreated onItemCreated;
  final OnItemDeleted onItemDeleted;
  final OnItemSelected onItemSelected;

  @override
  State<ExtendableListView> createState() => _ExtendableListViewState();
}

class _ExtendableListViewState<T> extends State<ExtendableListView> {
  late List<String> objects = widget.dataProvider();

  bool isActivate = false;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) {
        if (i < objects.length) {
          return InkWell(
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(child: widget.dataItem(objects[i])),
                  InkWell(
                    onTap: () {
                      widget.onItemDeleted(objects[i]);
                    },
                    child: const Icon(Icons.delete),
                  )
                ],
              ),
            ),
            onTap: () {
              return widget.onItemSelected(objects[i]);
            },
          );
        }
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
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
                      size: 20,
                    ),
                  )
                : SizedBox(
                    width: 300,
                    height: 20,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: controller,
                          maxLength: 20,
                          style: const TextStyle(fontSize: 12),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              counterText: "",
                              hintStyle: TextStyle(fontSize: 12),
                              hintText: "Max length 20",
                              fillColor: AppStyle.inputFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 18),
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
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.check,
                            size: 20,
                          ),
                          onTap: () {
                            setState(() {
                              widget.onItemCreated(controller.text);
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
                            size: 20,
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
      },
      itemCount: objects.length + 1,
    );
  }
}
