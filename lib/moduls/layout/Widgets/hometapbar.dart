import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class hometapbar extends StatelessWidget {
  final String text;
  final IconData iconns;
  final bool isselected;

  const hometapbar({
    super.key,
    required this.text,
    required this.iconns,
    required this.isselected,
  });

  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<app_provider>(context);
    final theme = Theme.of(context);
    /// هل الثيم داكن
    bool Isdark() => appprovider.currenttheme == ThemeMode.dark;


    /// الخلفية حسب الثيم والـ selection
    Color getBackgroundColor() {
      if (isselected) {
        return Isdark() ? colorpallete.darkblue : colorpallete.parimary;
      } else {
        return Isdark() ? colorpallete.darkTHEMR : colorpallete.darkblue;
      }
    }

    /// اللون الداخلي (آيكون والتيكست)
    Color getTextAndIconColor() {
      if (isselected) {
        return Isdark() ? Colors.white : colorpallete.darkblue;
      } else {
        return Isdark()? Colors.white : colorpallete.parimary;
      }
    }

    return Container(
      width: .28.w,
      height: 2.5*Checkbox.width,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
         color: getBackgroundColor(),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: colorpallete.parimary, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconns,
            color: getTextAndIconColor(),
            size: 25,
          ).Setoptionalpadding(context, 0, 0, 4, 2),
          Flexible(
            child: Text(
              text,
              style: TextStyle(color: getTextAndIconColor(),
             ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
