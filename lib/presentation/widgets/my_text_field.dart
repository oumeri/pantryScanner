import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color textColor;
  final FocusNode? focusNode;

  const MyTextFieldWidget({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textColor = Colors.black,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: textColor),
        focusNode: focusNode, // Use passed focusNode
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
