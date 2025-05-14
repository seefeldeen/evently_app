import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int? maxLine;
  final String? hintText;
  final void Function(String)? onChanged;
  const CustomTextField(
      {super.key,
        this.prefix,
        this.controller,
        this.prefixIcon,
        this.labelText,
        this.validator,
        this.maxLine,
        this.hintText,
        this.onChanged,
        this.isPassword = false,
        this.suffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color textColor = theme.brightness == Brightness.dark
        ? colorpallete.parimary // في الثيم الداكن اللون الأساسي
        : colorpallete.darkblue;
    return Container(
      decoration: BoxDecoration(
        border:   Border.all(
          color: colorpallete.darkblue,width: 0
        ),
          borderRadius: BorderRadius.circular(15),
      ) ,
      child: TextFormField(
      textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500),
        controller: widget.controller,
        obscureText: widget.isPassword ? isShow : false,
        obscuringCharacter: "*",
        validator: widget.validator,
        maxLines: widget.isPassword ? 1 : widget.maxLine,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
            prefix: widget.prefix,
            prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: widget.prefixIcon,
              ),enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: colorpallete.darkblue,
                  width: 1.5,
                ),
          borderRadius: BorderRadius.circular(15),
              ),
            suffixIcon: widget.isPassword
                ? IconButton(
                onPressed: () {
                  isShow = !isShow;
                  setState(() {});
                },
                icon: Icon(isShow
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded))
                : widget.suffixIcon,
            hintText: widget.hintText),
      ),
    ).Setoptionalpadding(
        context,
        .05,
        05,
        05,
        05,
        enablemediaquery: true,
      );
  }
}