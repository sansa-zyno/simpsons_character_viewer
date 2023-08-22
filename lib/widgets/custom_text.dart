import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final String? fontFamily;

  const CustomText(
      {required this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign,
      this.fontFamily,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: size ?? 14,
            color: color ?? Colors.black,
            fontFamily: fontFamily,
            fontWeight: weight),
        textAlign: textAlign);
  }
}
