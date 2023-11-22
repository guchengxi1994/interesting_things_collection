import 'package:flutter/material.dart';

class HighlightText {
  HighlightText._();

  ///高亮某些文字
  static const TextStyle lightTextStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  );

  /// 后续多个关键字高亮，参考 test\split_test.dart
  static InlineSpan formSpan(String src, String pattern) {
    src = src.replaceAll("\n", "...");
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        if (i > 0 && parts[i].length > 20) {
          if (parts[i - 1] == "") {
            print(1);
            span.add(TextSpan(text: "${parts[i + 1].substring(0, 20)}..."));
          } else if (parts.length > i && parts[i] == "") {
            print(2);
            span.add(TextSpan(
                text: "...${parts[i].substring(parts[i].length - 20)}"));
          } else {
            print(3);
            span.add(const TextSpan(text: "..."));
          }
        } else {
          span.add(const TextSpan(text: "..."));
        }

        if (i != parts.length - 1) {
          span.add(TextSpan(text: pattern, style: lightTextStyle));
        }
      }
    } else {
      span.add(TextSpan(text: src));
    }
    return TextSpan(children: span);
  }
}
