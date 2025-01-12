import 'package:flutter/material.dart';
import 'package:pantry_scanner/components/my_text_field.dart';

class EditableTextField extends StatefulWidget {
  final String initialValue;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color textColor;

  const EditableTextField({
    Key? key,
    required this.initialValue,
    required this.labelText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  _EditableTextFieldState createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool isEditing = false;
  late String currentValue;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;

    // Exit edit mode when focus is lost
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isEditing = false;
        });
      }
    });
  }

  void _toggleEditing() {
    setState(() {
      isEditing = true;
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!isEditing) _toggleEditing();
      },
      child: isEditing
          ? MyTextFieldWidget(
              labelText: widget.labelText,
              initialValue: currentValue,
              onChanged: (value) {
                setState(() {
                  currentValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              textColor: widget.textColor,
              focusNode: _focusNode, // Pass focusNode to manage focus
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.labelText}: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Expanded(
                  child: Text(
                    currentValue.isNotEmpty ? currentValue : 'Tap to enter ${widget.labelText}',
                    style: TextStyle(
                      fontSize: 16,
                      color: currentValue.isNotEmpty ? widget.textColor : Colors.grey,
                      fontStyle: currentValue.isNotEmpty ? FontStyle.normal : FontStyle.italic,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevents overflow for long text
                  ),
                ),
              ],
            )

    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}