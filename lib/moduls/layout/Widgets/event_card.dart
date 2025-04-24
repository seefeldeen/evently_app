import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.eventddatamodel});
  final EventModel eventddatamodel;
  // final String eventDate;
  @override
  Widget build(BuildContext context) {
    //
      var eventprovider = Provider.of<LayoutProvider>(context);

    DateTime eventDate = DateTime.parse(eventddatamodel.eventDate);

    // تنسيق التاريخ باستخدام DateFormat (اختياري، حسب الشكل اللي حابب تعرضه)
    String formattedDate = DateFormat('dd MMM yyyy').format(eventDate); // مثلا "30 Apr 2025"

    // عرض الوقت بشكل مباشر (هكذا نعرضه كما هو من الموديل)
    String formattedTime = eventddatamodel.eventTime; // مثلا "6:37 AM"
    return  // Apply border radius to ClipRRect to ensure clipping
       Container(
        padding: EdgeInsets.all(8),
        width: .85.w,
        height: .25.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorpallete.darkblue,  // Border color
            width: 2.0,          // Border width
          ),
          image: DecorationImage(
            image: AssetImage(eventddatamodel.categoryImage),
            fit: BoxFit.contain, // Adjust how the image fits inside the container
          ),
          borderRadius: BorderRadius.circular(18), // Apply the same border radius to the container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: .25.w,
              height: .06.h,
              decoration: BoxDecoration(
                color: colorpallete.parimary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(formattedTime,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ).Setoptionalpadding(context, 2, 0, 0, 4),
                  Text(
                    formattedDate,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ).Setoptionalpadding(context, 2, 0, 0, 4),
                    ],
                  ),
                ],
              ),
            ).Setoptionalpadding(context, 4, 0, 4, 8),
            Container(
              padding: EdgeInsets.all(12),
              width: .9.w,
              height: .06.h,
              decoration: BoxDecoration(
                color: colorpallete.parimary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      eventddatamodel.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      eventprovider.setfavourit(eventddatamodel);
                    },
                    child: eventddatamodel.isFav
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border_outlined),
                  ),
                ],
              ),
            ).Setoptionalpadding(context, .092.h, .01.h, 0, 0),
          ],
        ),
      ).Sethorizontalpadding(context, .002);
  }
}
