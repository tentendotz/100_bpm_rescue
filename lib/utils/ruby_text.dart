import 'package:flutter/material.dart';

/// 文字とルビ情報
class RubyChar {
  final String text;
  final String ruby;
  RubyChar(this.text, this.ruby);
}

/// 横並びでまとめるルビ表示
class RubyTextRow extends StatelessWidget {
  final List<RubyChar> chars;
  final TextStyle? textStyle;
  final TextStyle? rubyStyle;

  const RubyTextRow({
    super.key,
    required this.chars,
    this.textStyle,
    this.rubyStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: chars.map((c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(c.ruby, style: rubyStyle ?? const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(c.text, style: textStyle ?? const TextStyle(fontSize: 24)),
          ],
        );
      }).toList(),
    );
  }
}