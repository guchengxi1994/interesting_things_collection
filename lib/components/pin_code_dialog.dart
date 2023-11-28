import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';

class PinCodeDialog extends ConsumerStatefulWidget {
  const PinCodeDialog({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  ConsumerState<PinCodeDialog> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends ConsumerState<PinCodeDialog> {
  final TextEditingController pincodeController = TextEditingController();
  late String contentMessage = "";

  @override
  void dispose() {
    // pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      width: 320,
      height: 157,
      child: contentMessage == ""
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                _buildPincodeRegion(),
                const Padding(
                    padding: EdgeInsets.only(left: 21),
                    child: Text(
                      "请输入六位密钥",
                      style: TextStyle(
                          color: Color.fromARGB(
                            255,
                            159,
                            159,
                            159,
                          ),
                          fontSize: 12),
                    )),
                _buildButtons()
              ],
            )
          : Center(
              child: Text(contentMessage),
            ),
    );
  }

  Widget _buildTitle() {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 246, 250, 254),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(5), right: Radius.circular(5))),
      padding: const EdgeInsets.only(left: 21),
      height: 31,
      alignment: Alignment.centerLeft,
      child: Text(
        // "Input an initial passcode",
        widget.message,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  bool openEye = false;

  Widget _buildPincodeRegion() {
    return Container(
      height: 50,
      width: 250,
      margin: const EdgeInsets.only(top: 20, left: 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 200,
              child: PinCodeTextField(
                  controller: pincodeController,
                  cursorColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 12),
                  obscuringCharacter: "*",
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      inactiveFillColor: Colors.white,
                      selectedColor: AppStyle.pinCodeColor,
                      selectedFillColor: Colors.white,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 32,
                      fieldWidth: 24,
                      activeFillColor: Colors.white,
                      inactiveColor: const Color.fromARGB(255, 218, 223, 229)),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  obscureText: !openEye,
                  appContext: context,
                  length: 6,
                  onChanged: (v) {})),
          InkWell(
            onTap: () {
              setState(() {
                openEye = !openEye;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: 24,
              height: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: const Color.fromARGB(255, 218, 223, 229),
                      width: 1)),
              child: openEye
                  ? Image.asset("assets/icons/open_eye.png")
                  : Image.asset("assets/icons/close_eye.png"),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  contentMessage = "You can enable this in the Settings page";
                });
                ref.read(settingsNotifier.notifier).changeEnablePwd(false);

                Future.delayed(const Duration(seconds: 2)).then((value) {
                  Navigator.of(context).pop("");
                });
              },
              child: Container(
                width: 73,
                height: 21,
                padding: const EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppStyle.pinCodeColor),
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text(
                    "取消",
                    style:
                        TextStyle(color: AppStyle.pinCodeColor, fontSize: 12),
                  ),
                ),
              )),
          const SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () {
                setState(() {
                  contentMessage = "OK";
                });

                Future.delayed(const Duration(seconds: 2)).then((value) {
                  Navigator.of(context).pop("");
                });
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 1),
                width: 73,
                height: 21,
                decoration: BoxDecoration(
                    color: AppStyle.pinCodeColor,
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
