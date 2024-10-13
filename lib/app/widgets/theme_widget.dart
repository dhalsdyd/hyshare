import 'package:flutter/material.dart';
import 'package:hyshare/app/core/util/isDarkMode.dart';

class FGBPText extends StatelessWidget {
  const FGBPText(this.data, {super.key, this.style});

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    Color color = context.isDarkMode ? Colors.white : Colors.black;

    if (style == null) {
      return Text(data, style: TextStyle(color: color));
    }
    return Text(data, style: style!.copyWith(color: color));
  }
}
