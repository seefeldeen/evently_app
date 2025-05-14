import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/Customtextshape.dart';

class Mapeventcard extends StatelessWidget {
  const Mapeventcard({super.key, required this.eventModel,
    required this.onpress});

  final EventModel eventModel;
  final Function(double,double) onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onpress(eventModel.latitude, eventModel.longitude);
      },
      child: Container(
          width: .7.w,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9), // لون خلفية شبه شفاف، أو شيله خالص لو مش عايز
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3))
              ],
              border: Border.all(color: colorpallete.darkblue),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AspectRatio(
                  aspectRatio: 138 / 78,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        eventModel.categoryImage,
                      ))).Setoptionalpadding(context, 6, 6, 4, 2),
              const SizedBox(width: 4),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const SizedBox(height: 8),
                    Text(eventModel.title,
                        maxLines: 2,
                        style: const TextStyle(
                            color: colorpallete.darkblue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis)),
                    const SizedBox(height: 12),
                    Row(
                      children: [const Icon(Icons.location_on,color: colorpallete.darkblue,),
                        Customtextshape.Getsmalltextcolored(
                            "${eventModel.longitude.floor()} : ${eventModel.latitude.floor()}",
                            context, colorpallete.darkblue),
                      ],
                    ),
                  ]))
            ],
          ))
          .Setresponsivepadding(context, .01, .01, .0, .0),
    );
  }
}
