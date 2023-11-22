import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:weaving/catalog/components/editor.dart';
import 'package:weaving/common/base64_utils.dart';
import 'package:weaving/gen/strings.g.dart';
import 'package:weaving/isar/thing.dart';
import 'package:weaving/style/app_style.dart';
import 'package:popup_card/popup_card.dart';

import '../notifiers/catalog_details_notifier.dart';
import '../notifiers/catalog_details_state.dart';
import 'add_tag_button.dart';

const double textWidth = 80;
const TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
typedef OnNewThing = void Function(Thing);

// ignore: must_be_immutable
class CatalogDetails extends ConsumerWidget {
  CatalogDetails({super.key, required this.catalogId, this.onNewThing});
  final int catalogId;
  final OnNewThing? onNewThing;

  late final notifier =
      AsyncNotifierProvider<CatalogDetailsNotifier, CatalogDetailsState>(() {
    return CatalogDetailsNotifier(catalogId: catalogId);
  });

  // ignore: avoid_init_to_null
  late Thing thing = Thing();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(notifier);

    return Builder(builder: (c) {
      return switch (details) {
        AsyncValue<CatalogDetailsState>(:final value?) => SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: textWidth,
                      child: Text(
                        t.catalogs.details.name,
                        style: textStyle,
                      ),
                    ),
                    Expanded(child: Text(value.catalogName.toString()))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: textWidth,
                      child: Text(
                        t.catalogs.details.tags,
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Tags(
                        itemCount: value.tags.length + 1,
                        itemBuilder: (int index) {
                          if (index < value.tags.length) {
                            return Tooltip(
                                message: value.tags[index],
                                child: ItemTags(
                                  pressEnabled: false,
                                  removeButton: ItemTagsRemoveButton(
                                    icon: Icons.delete,
                                    onRemoved: () {
                                      //required
                                      final List<String> list =
                                          List.from(value.tags);
                                      list.removeAt(index);
                                      ref.read(notifier.notifier).updateCatalog(
                                          value.catalogName, list);
                                      return true;
                                    },
                                  ),
                                  title: value.tags[index],
                                  index: index,
                                ));
                          }
                          return AddTagButton(
                            onSave: (String s) {
                              // print(s);
                              if (s != "") {
                                final List<String> list = List.from(value.tags);
                                list.add(s);
                                ref
                                    .read(notifier.notifier)
                                    .updateCatalog(value.catalogName, list);
                              }
                            },
                          );
                        },
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: textWidth,
                      child: Text(
                        t.catalogs.details.rating,
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                        child: RatingStars(
                      value: value.rating,
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
                      valueLabelPadding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 8),
                      valueLabelMargin: const EdgeInsets.only(right: 8),
                      starOffColor: const Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: textWidth,
                      child: Text(
                        t.catalogs.details.createAt,
                        style: textStyle,
                      ),
                    ),
                    Expanded(
                        child: Text(formatDate(
                            DateTime.fromMillisecondsSinceEpoch(value.createAt),
                            [yyyy, "-", mm, "-", dd])))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: textWidth,
                      child: Text(
                        t.catalogs.details.operations,
                        style: textStyle,
                      ),
                    ),
                    // ElevatedButton(onPressed: () {}, child: Text("Add"))
                    PopupItemLauncher(
                      tag: 'test-new-$catalogId',
                      popUp: PopUpItem(
                        reservedAppbarHeight: AppStyle.appbarHeight,
                        alignment: Alignment.topRight,
                        tag: 'test-new-$catalogId',
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width * .8,
                          height: Platform.isWindows
                              ? MediaQuery.of(context).size.height -
                                  AppStyle.appbarHeight
                              : MediaQuery.of(context).size.height,
                          child: Editor(
                            savedData: "",
                            saveToJson: (p0, p1, p2) async {
                              SmartDialog.showLoading();
                              thing.catalogId = catalogId;
                              thing.name = p2;
                              thing.fullText = p1;
                              thing.remark = p0;

                              if (onNewThing != null) {
                                onNewThing!(thing);
                              }

                              await Future.delayed(const Duration(seconds: 1));
                              SmartDialog.dismiss();
                            },
                            savePreview: (p0) async {
                              SmartDialog.showLoading();
                              thing.preview = Base64Utils.uint8List2Base64(p0);
                              await Future.delayed(const Duration(seconds: 1));
                              SmartDialog.dismiss();
                            },
                          ),
                        ),
                      ),
                      child: Material(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: const MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Icon(
                            Icons.add_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    });
  }
}
