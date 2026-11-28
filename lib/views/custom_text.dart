import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;

  const CustomText({super.key, required this.text, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'm6x11',
        fontSize: fontSize ?? 16,
        color: color,
      ),
    );
  }
}
