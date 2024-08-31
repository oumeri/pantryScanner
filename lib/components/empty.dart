import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Empty extends StatelessWidget {

  final String text;

  const Empty({
    super.key,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty pantry image
            SvgPicture.asset(
              'assets/images/emptyList.svg',
              width: 100,
              height: 100,
            ),


            Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
         ),
    );
  }
}