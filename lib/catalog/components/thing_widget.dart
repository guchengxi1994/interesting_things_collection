import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interesting_things_collection/catalog/notifiers/things_hover_notifier.dart';
import 'package:interesting_things_collection/isar/thing.dart';
import 'package:interesting_things_collection/notifier/color_notifier.dart';
import 'package:interesting_things_collection/style/app_style.dart';
import 'package:popup_card/popup_card.dart';

import 'editor.dart';

class ThingWidget extends ConsumerWidget {
  const ThingWidget({super.key, required this.thing});
  final Thing thing;

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
      child: PopupItemLauncher(
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
              saveToJson: (p0) {
                thing.remark = p0;
                ref.read(thingsHoverNotifier.notifier).saveThing(thing);
              },
            ),
          ),
        ),
        child: _buildItem(context, ref),
      ),
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
                value: thing.score ?? 3.1,
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
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
