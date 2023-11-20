import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinputWidget extends StatefulWidget {
  const PinputWidget({Key? key}) : super(key: key);

  @override
  State<PinputWidget> createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Optionally you can use form to validate the Pinput
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(70, 69, 66, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(24),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return FittedBox(
      child: Pinput(
        length: 4,
        controller: pinController,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 16),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15999999865889549),
                offset: Offset(0, 3),
                blurRadius: 16,
              ),
            ],
          ),
        ),
        onCompleted: (value) {},
        // onClipboardFound: (value) {
        //   debugPrint('onClipboardFound: $value');
        //   controller.setText(value);
        // },
        showCursor: true,
        cursor: cursor,
      ),
    );
  }
}
