import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/Widgets/event_card.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class fav_tap extends StatelessWidget {
  const fav_tap({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<app_provider>(context);
    final eventProvider = Provider.of<LayoutProvider>(context);
    final theme = Theme.of(context);

    // التأكد من تحميل الفيف إيفينتس بعد أول عملية بناء للواجهة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LayoutProvider>(context, listen: false).getfavevent(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.favouriteevents,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: colorpallete.parimary,
          ),
        ),
        centerTitle: true,
      ),
      body: eventProvider.favEvents.isEmpty
          ? Center(
        child: Text(
          context.tr.nofavouriteevents,  // التأكد من وجود النص باللغة المناسبة
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
      )
          : ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: .015.w, vertical: .02.h),
        itemBuilder: (context, index) {
          final event = eventProvider.favEvents[index];
          return EventCard(eventddatamodel: event);
        },
        separatorBuilder: (context, index) => SizedBox(height: .01.h),
        itemCount: eventProvider.favEvents.length,
      ),
    );
  }
}
