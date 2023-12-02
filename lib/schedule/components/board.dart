import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';
import 'package:weaving/style/app_style.dart';

import 'listview_footer.dart';
import 'listview_header.dart';

class CustomBoard extends ConsumerStatefulWidget {
  const CustomBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomBoard> createState() => _BoardState();
}

Map<String, dynamic> kanbanData = {
  'Blocked': {
    'color': const Color.fromRGBO(239, 147, 148, 1),
    'items': [
      {
        'title': 'Making A New Trend In Poster',
        'date': '17 Dec 2022',
        'tasks': '30/48'
      },
      {'title': 'Create Remarkable', 'date': '17 Nov 2022', 'tasks': '15/56'},
    ]
  },
  'Pending': {
    'color': const Color.fromRGBO(239, 147, 148, 1),
    'items': [
      {
        'title': 'Making A New Trend In Poster',
        'date': '17 Dec 2022',
        'tasks': '30/48'
      },
      {'title': 'Create Remarkable', 'date': '17 Nov 2022', 'tasks': '15/56'},
      {
        'title': 'Advertisers Embrace Rich Media',
        'date': '22 Oct 2022',
        'tasks': '18/67'
      },
      {
        'title': 'Meet the People Who Train',
        'date': '15 Dec 2022',
        'tasks': '24/46'
      }
    ]
  },
  'In progress': {
    'color': const Color.fromRGBO(255, 230, 168, 1),
    'items': [
      {
        'title': 'Advertising Outdoors',
        'date': '17 Dec 2022',
        'tasks': '53/70'
      },
      {'title': 'Create Remarkable', 'date': '17 Nov 2022', 'tasks': '15/56'},
      {
        'title': 'Manufacturing Equipment',
        'date': '17 Dec 2022',
        'tasks': '35/65'
      },
      {
        'title': 'Advertising Outdoors',
        'date': '17 Dec 2022',
        'tasks': '13/29'
      },
      {
        'title': 'Truck Side Advertising Time',
        'date': '17 Dec 2022',
        'tasks': '39/50'
      },
      {
        'title': 'Importance of The Custom',
        'date': '17 Dec 2022',
        'tasks': '30/90'
      },
    ]
  },
  'Done': {
    'color': const Color.fromRGBO(148, 235, 168, 1),
    'items': [
      {
        'title': 'Creative Outdoor Ads',
        'date': '23 Dec 2022',
        'tasks': '20/20'
      },
      {
        'title': 'Promotional Advertising Speciality',
        'date': '17 Nov 2022',
        'tasks': '15/15'
      },
      {
        'title': 'Search Engine OPtimization',
        'date': '22 Oct 2022',
        'tasks': '67/67'
      },
    ]
  },
};

class _BoardState extends ConsumerState<CustomBoard> {
  @override
  Widget build(BuildContext context) {
    return KanbanBoard(
      List.generate(kanbanData.length, (index) {
        final element = kanbanData.values.elementAt(index);
        return BoardListsData(
            backgroundColor: const Color.fromRGBO(249, 244, 240, 1),
            width: 350,
            footer: const ListFooter(),
            headerBackgroundColor: Colors.transparent,
            header: ListHeader(
              title: kanbanData.keys.elementAt(index),
              stateColor: element['color'],
            ),
            items: List.generate(element['items'].length, (index) {
              int totalTasks = int.parse(
                  element['items'][index]['tasks'].toString().split('/').last);
              int completedTasks = int.parse(
                  element['items'][index]['tasks'].toString().split('/').first);

              return Card(
                child: Text(element['items'][index]['title']),
              );
            }));
      }),
      onItemLongPress: (cardIndex, listIndex) {},
      onItemReorder: (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {
        print(oldCardIndex);
        print(newCardIndex);
        print(oldListIndex);
        print(newListIndex);
      },
      boardDecoration: const BoxDecoration(
          color: Colors.transparent, borderRadius: AppStyle.leftTopRadius),
      listDecoration: BoxDecoration(color: Colors.transparent),
      onListLongPress: (listIndex) {},
      onListReorder: (oldListIndex, newListIndex) {
        print(oldListIndex);
        print(newListIndex);
      },
      onItemTap: (cardIndex, listIndex) {},
      onListTap: (listIndex) {},
      onListRename: (oldName, newName) {},
      backgroundColor: Colors.transparent,
      displacementY: 124,
      displacementX: 100,
      textStyle: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}
