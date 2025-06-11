import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.eventddatamodel});
  final EventModel eventddatamodel;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // final String eventDate;
  @override
  Widget build(BuildContext context) {
    //
      var eventprovider = Provider.of<LayoutProvider>(context);

    DateTime eventDate = DateTime.parse(widget.eventddatamodel.eventDate);

    // تنسيق التاريخ باستخدام DateFormat (اختياري، حسب الشكل اللي حابب تعرضه)
    String formattedDate = DateFormat('dd MMM yyyy').format(eventDate); // مثلا "30 Apr 2025"

    // عرض الوقت بشكل مباشر (هكذا نعرضه كما هو من الموديل)
    String formattedTime = widget.eventddatamodel.eventTime; // مثلا "6:37 AM"
    return  // Apply border radius to ClipRRect to ensure clipping
       InkWell(
         onTap: () {
           navigatorKey.currentState!.pushNamed( '/event_details',
           arguments: widget.eventddatamodel);
           EasyLoading.dismiss(
             animation: true,
           );
         }
         ,
         child: Container(
          padding: const EdgeInsets.all(8),
          width: .85.w,
          height: .25.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: colorpallete.darkblue,  // Border color
              width: 2.0,          // Border width
            ),
            image: DecorationImage(
              image: AssetImage(widget.eventddatamodel.categoryImage),
              fit: BoxFit.contain, // Adjust how the image fits inside the container
            ),
            borderRadius: BorderRadius.circular(18), // Apply the same border radius to the container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: .27.w,
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
                        Flexible(
                          child: Text(formattedTime,
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ).Setoptionalpadding(context, 2, 0, 0, 4),
                        ),
                    Flexible(
                      child: Text(
                        formattedDate,
                            style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ).Setoptionalpadding(context, 2, 0, 0, 4),
                    ),
                      ],
                    ),
                  ],
                ),
              ).Setoptionalpadding(context, 4, 0, 4, 8),
              Container(
                padding: const EdgeInsets.all(8),
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
                        widget.eventddatamodel.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
            FirebaseFunctions.setFav(widget.eventddatamodel) ;
            print(widget.eventddatamodel.isFav);
                      },
                      child: widget.eventddatamodel.isFav
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
              ).Setoptionalpadding(context, .09.h, .00.h, 0, 0),
            ],
          ),
               ).Sethorizontalpadding(context, .002),
       );
  }
}
