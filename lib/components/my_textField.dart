
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius:  BorderRadius.circular(12),

      ),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white), // Text color
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            border:  OutlineInputBorder(
              borderRadius:  BorderRadius.circular(12)
              ),
          ),
        ),
    );
  }
}