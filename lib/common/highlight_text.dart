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
    src = src.replaceAll("\n", "");
    List<TextSpan> span = [];
    List<String> parts = src.split(pattern);
    if (parts.length > 1) {
      for (int i = 0; i < parts.length; i++) {
        if (parts[i].length <= 20) {
          span.add(TextSpan(text: parts[i]));
        } else {
          String left = parts[i].substring(0, 10);
          String right = parts[i].substring(parts[i].length - 10);

          String r = "$left...$right";
          span.add(TextSpan(text: r));
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
