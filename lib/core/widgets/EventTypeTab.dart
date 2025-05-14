import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:flutter/material.dart';

class Eventtypetab extends StatelessWidget {

  final String text ;
  final IconData iconns ;
  final bool isselected;

   const Eventtypetab({super.key,
    required this.text, required this.iconns,
    required this.isselected});

  @override
  Widget build(BuildContext context) {
    return   Container(

    width: .28.w, height: 2.5* Checkbox.width
    ,padding: const EdgeInsets.all(6)
      ,decoration: BoxDecoration(
        color: isselected? colorpallete.parimary : colorpallete.darkblue, // You can set a background color if needed
        borderRadius: BorderRadius.circular(50), // This will round the corners
        border:
          Border.all(color: colorpallete.parimary,width: 2),
      ),
      child: Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconns,
            color: isselected? colorpallete.darkblue : colorpallete.parimary, // Corrected the typo here
            size: 25,
          ).Setoptionalpadding(context, 0, 0, 4, 2),
          Text(
            text,
            style: TextStyle(color: isselected? colorpallete.darkblue : colorpallete.parimary),
          ),
        ],
      ),
    );
  }
}
