import 'package:flutter/material.dart';

class Lostitemcard extends StatelessWidget {

  final Widget lostItem;


  const Lostitemcard({
      super.key,
      required this.lostItem,
      });



  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: lostItem),
     );
  }
}