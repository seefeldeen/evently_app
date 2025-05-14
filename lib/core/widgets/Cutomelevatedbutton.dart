import 'package:flutter/material.dart';

class Cutomelevatedbutton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color buttoncolor;
  final Color textcolor;

  final double buttonradius;

  const Cutomelevatedbutton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.buttoncolor,
      this.buttonradius = 12,
      this.textcolor = Colors.blueAccent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
          backgroundColor: buttoncolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonradius)),
        ),
        child: Text(
          text,
        ));
  }
}
