
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String text;
  final void Function()? onTap;
  final double? fontSize;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? color;
  final double? height;
  final double? width;
  final double? borderRadius;

  const MyButton({
    super.key,
    required this.text,
    this.fontSize,
    this.width,
    this.height,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.color,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.black, //Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 14, vertical: verticalPadding ?? 10),
        width: width ?? double.infinity,
        height: height ?? 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize ?? 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}