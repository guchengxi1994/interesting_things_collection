// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:weaving/common/hashcode_extension.dart';
// ignore:  depend_on_referenced_packages
import 'package:uuid/uuid.dart';

const int MAX_BYTES_LENGTH = 32 * 1024; // 32kb

class DataTransferModel {
  int? count;
  int? id;
  String? content;
  int? uniqueCode;
  String? uuid;

  DataTransferModel(
      {required this.content,
      required this.count,
      required this.uniqueCode,
      required this.uuid,
      required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['id'] = id;
    data['content'] = content;
    data['uniqueCode'] = uniqueCode;
    data['uuid'] = uuid;
    return data;
  }

  DataTransferModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    id = json['id'];
    content = json['content'];
    uniqueCode = json['uniqueCode'];
    uuid = json['uuid'];
  }
}

extension ListTransferModelExtension on Iterable<DataTransferModel> {
  List<DataTransferModel> getByUUID(String uuid) {
    return where((element) => element.uuid == uuid).toList()
      ..sort((a, b) => a.id!.compareTo(b.id!));
  }

  String? restore() {
    if (first.count == 1) {
      // return first.content;
      return utf8.decode(base64.decode(first.content!));
    }

    if (first.count == length) {
      final String result = map((e) => e.content!).reduce((value, element) =>
          utf8.decode(base64.decode(value)) +
          utf8.decode(base64.decode(element)));
      if (result.fastHash() == first.uniqueCode) {
        return result;
      }
    }
    return null;
  }
}

const Uuid uuid = Uuid();

List<DataTransferModel> splitToTransferModel(String s) {
  List<int> bytes = utf8.encode(s);
  if (bytes.length <= MAX_BYTES_LENGTH) {
    return [
      DataTransferModel(
          content: base64.encode(bytes),
          uuid: uuid.v4(),
          uniqueCode: 0,
          id: 0,
          count: 1)
    ];
  }

  List<DataTransferModel> results = [];
  int uniqueCode = s.fastHash();
  String u = uuid.v4();
  int l = 0;
  int count = 0;
  int index = 0;
  if (bytes.length % MAX_BYTES_LENGTH == 0) {
    count = bytes.length % MAX_BYTES_LENGTH;
  } else {
    count = bytes.length ~/ MAX_BYTES_LENGTH + 1;
  }

  while (l < bytes.length) {
    final List<int> b;
    if (l + MAX_BYTES_LENGTH >= bytes.length) {
      b = bytes.sublist(l, bytes.length);
    } else {
      b = bytes.sublist(l, l + MAX_BYTES_LENGTH);
    }
    results.add(DataTransferModel(
        content: base64.encode(b),
        count: count,
        uniqueCode: uniqueCode,
        uuid: u,
        id: index));

    l += MAX_BYTES_LENGTH;
    index += 1;
  }

  return results;
}
