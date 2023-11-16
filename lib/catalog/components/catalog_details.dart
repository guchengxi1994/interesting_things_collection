import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

import '../notifiers/catalog_details_notifier.dart';
import '../notifiers/catalog_details_state.dart';
import 'add_tag_button.dart';

class CatalogDetails extends ConsumerWidget {
  CatalogDetails({super.key, required this.catalogId});
  final int catalogId;
  late final notifier =
      AsyncNotifierProvider<CatalogDetailsNotifier, CatalogDetailsState>(() {
    return CatalogDetailsNotifier(catalogId: catalogId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(notifier);

    return Builder(builder: (c) {
      return switch (details) {
        AsyncValue<CatalogDetailsState>(:final value?) => Column(
            children: [
              Text(value.catalogName.toString()),
              Tags(
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
              RatingStars(
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
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              )
            ],
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      };
    });
  }
}
