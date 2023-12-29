import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

class EditorInsertListview extends StatefulWidget {
  const EditorInsertListview({super.key});

  @override
  State<EditorInsertListview> createState() => _EditorInsertListviewState();
}

class _EditorInsertListviewState extends State<EditorInsertListview> {
  late FocusNode focusNode;
  int focusedIndex = 0;
  final ScrollController controller = ScrollController();
  late ListObserverController observerController =
      ListObserverController(controller: controller);

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    focusNode.requestFocus();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        observerController.animateTo(
          index: focusedIndex,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
    );

    return RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          // print(event);
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              setState(() {
                focusedIndex = (focusedIndex + 1) % 10; // Assuming 10 items
              });
            } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              setState(() {
                focusedIndex = (focusedIndex - 1) % 10; // Assuming 10 items
              });
            } else if (event.logicalKey == LogicalKeyboardKey.enter) {
              print(focusedIndex);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          width: 300,
          height: 300,
          child: ListViewObserver(
            controller: observerController,
            child: ListView.builder(
                controller: controller,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Item $index',
                      style: TextStyle(
                          color: index == focusedIndex ? Colors.blue : null),
                    ),
                  );
                }),
          ),
        ));
  }
}
