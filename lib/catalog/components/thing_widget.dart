import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:weaving/catalog/notifiers/things_hover_notifier.dart';
import 'package:weaving/common/base64_utils.dart';
import 'package:weaving/isar/thing.dart';
import 'package:weaving/notifier/color_notifier.dart';
import 'package:weaving/notifier/settings_notifier.dart';
import 'package:weaving/style/app_style.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:popup_card/popup_card.dart';

import 'editor.dart';

typedef OnRatingChange = void Function(double);

class ThingWidget extends ConsumerWidget {
  const ThingWidget({super.key, required this.thing, this.onRatingChange});
  final Thing thing;
  final OnRatingChange? onRatingChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(thingsHoverNotifier.notifier).changeIndex(thing.id);
      },
      onExit: (event) {
        ref.read(thingsHoverNotifier.notifier).changeIndex(0);
      },
      cursor: SystemMouseCursors.click,
      child: ref.watch(settingsNotifier).showPreviewWhenHoverOnThings
          ? JustTheTooltip(
              content: SizedBox(
                width: 300,
                height: 300,
                child: thing.preview == null
                    ? Image.asset("assets/empty.png")
                    : Image.memory(Base64Utils.base64ToBytes(thing.preview!)),
              ),
              child: _buildChild(context, ref))
          : _buildChild(context, ref),
    );
  }

  Widget _buildChild(BuildContext context, WidgetRef ref) {
    return PopupItemLauncher(
      tag: 'test-${thing.id}',
      popUp: PopUpItem(
        reservedAppbarHeight: AppStyle.appbarHeight,
        alignment: Alignment.topRight,
        tag: 'test-${thing.id}',
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * .8,
          height: Platform.isWindows
              ? MediaQuery.of(context).size.height - AppStyle.appbarHeight
              : MediaQuery.of(context).size.height,
          child: Editor(
            savedData: thing.remark ?? "",
            saveToJson: (p0) async {
              SmartDialog.showLoading();
              thing.remark = p0;
              ref.read(thingsHoverNotifier.notifier).saveThing(thing);
              await Future.delayed(const Duration(seconds: 1));
              SmartDialog.dismiss();
            },
            savePreview: (p0) async {
              SmartDialog.showLoading();

              thing.preview = Base64Utils.uint8List2Base64(p0);
              await ref.read(thingsHoverNotifier.notifier).saveThing(thing);
              await Future.delayed(const Duration(seconds: 1));
              SmartDialog.dismiss();
            },
          ),
        ),
      ),
      child: _buildItem(context, ref),
    );
  }

  Widget _buildItem(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(thingsHoverNotifier);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: 0.8 *
          MediaQuery.of(context).size.width *
          0.8 *
          AppStyle.catalogOnHoverFactor,
      height: 50 * AppStyle.catalogOnHoverFactor,
      child: Center(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppStyle.catalogCardBorderColors[
                      ref.read(colorNotifier).currentColor],
                  blurRadius: 10,
                  spreadRadius: 2.5,
                ),
                const BoxShadow(
                  color: Color(0xFFE8E8E8),
                  blurRadius: 10,
                  spreadRadius: 2.5,
                )
              ]),
          width: currentIndex == thing.id
              ? 0.8 *
                  MediaQuery.of(context).size.width *
                  0.8 *
                  AppStyle.catalogOnHoverFactor
              : 0.8 * MediaQuery.of(context).size.width * 0.8,
          height: currentIndex == thing.id
              ? 50 * AppStyle.catalogOnHoverFactor
              : 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(thing.name.toString()),
              RatingStars(
                value: thing.score ?? 0,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
                onValueChanged: (value) {
                  // print(value);
                  if (onRatingChange != null) {
                    onRatingChange!(value);
                  }
                },
                starCount: 5,
                starSize: 20,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              )
            ],
          ),
        ),
      ),
    );
  }
}
