import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class event_card extends StatelessWidget {
  const event_card({super.key, required this.eventddatamodel});
final Eventdata eventddatamodel ;
  @override
  Widget build(BuildContext context) {
    return  Container(padding: EdgeInsets.all(8),
      width: .97.w,
      height: .25.h,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(eventddatamodel.eventimage)),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: .1.w,
            height: .065.h,
            decoration: BoxDecoration(
                color: colorpallete.parimary,
                borderRadius: BorderRadius.circular(8)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat("dd MMM").format( eventddatamodel.eventdate),
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Nov",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ).Setoptionalpadding(context, 4, 0, 4, 8),
          Container(
              padding: EdgeInsets.all(12),
              width: .93.w, height: .06.h,
              decoration: BoxDecoration(
                  color: colorpallete.parimary,
                  borderRadius: BorderRadius.circular(14)),
              child:
              Row(
                  children: [
                    Expanded(
                      child: Text(
                        eventddatamodel.eventtitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(Icons.favorite_border_outlined)
                  ])
          ).Setoptionalpadding(context, .092.h, .01.h, 4, 4)

        ],
      ),
    );
  }
}
