import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customtextshape {

 static Widget Getsmalltext(String textdata, BuildContext context){


   return Text(textdata, style: Theme.of(context)
       .textTheme
       .titleMedium
       ?.copyWith(
     fontSize: 18,
     decorationThickness: 2,
     decorationColor: colorpallete.parimary,
     color: colorpallete.parimary,));
  }

  static Widget Getbigtext(String textdata, BuildContext context){


   return Text(textdata, style: Theme.of(context)
       .textTheme
       .titleMedium
       ?.copyWith(
     fontWeight: FontWeight.bold,
     fontSize: .035.h,
     decorationThickness: 2,
     decorationColor: colorpallete.parimary,
     color: colorpallete.parimary,));
  }

  static Widget Getbigtextchoose(String textdata, BuildContext context,Color textcolor ){


   return Text(textdata, style: Theme.of(context)
       .textTheme
       .titleMedium
       ?.copyWith(
     fontWeight: FontWeight.bold,
     fontSize: .030.h,
     decorationThickness: 2,
     decorationColor: textcolor,
     color: textcolor,));
  }



}