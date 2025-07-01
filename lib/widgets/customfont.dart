import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final String fontFamily;

  const CustomFont({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}