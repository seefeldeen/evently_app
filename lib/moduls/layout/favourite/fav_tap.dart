import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/Widgets/event_card.dart';
import 'package:flutter/material.dart';

class fav_tap extends StatelessWidget {
  const fav_tap({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr.favouriteevents,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: colorpallete.parimary,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<EventModel>>(
        stream: FirebaseFunctions.getFavEventsStream(), // الدالة اللي بتجيب الداتا من Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                context.tr.nofavouriteevents,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorpallete.parimary,
                ),
              ),
            );
          }

          final favEvents = snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: .015.w, vertical: .02.h),
            itemBuilder: (context, index) {
              final event = favEvents[index];
              return EventCard(eventddatamodel: event);
            },
            separatorBuilder: (context, index) => SizedBox(height: .01.h),
            itemCount: favEvents.length,
          );
        },
      ),
    );
  }
}
