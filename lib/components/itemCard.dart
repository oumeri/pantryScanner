import 'package:flutter/material.dart';

class Itemcard extends StatelessWidget {

  final Widget item;


  const Itemcard({
      super.key,
      required this.item,
      });



  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: item
            )
          ),
     );
  }
}