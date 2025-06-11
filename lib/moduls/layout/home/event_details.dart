import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/home/event_locationcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class event_details extends StatelessWidget {
  final EventModel event;
  const event_details({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.tr.eventdetails,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
                size: 26,
              ),
              onPressed: () {
                navigatorkey.currentState!.pushNamed(
                  route_names.eventcreation,
                  arguments: event,
                );
                // Handle favorite button press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                FirebaseFunctions.deleteEvent(event).then((value) {
                  EasyLoading.show
                      (status: context.tr.eventdeleted);
                  EasyLoading.dismiss(animation: true);
                  navigatorkey.currentState!.pop();
                }).catchError((error) {
                  EasyLoading.dismiss(animation: true);
                  EasyLoading.showError(context.tr.somethingWentWrong);
                });
                // Handle favorite button press
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: .01.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  event.categoryImage, // Corrected here
                  height: .25.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ).Setoptionalpadding(
                    context, .001.h, .01.h, 0.015.w, .015.w),
              ),
              Customtextshape.Getbigtextchoose(
                      event.title, context, colorpallete.darkblue)
                  .Setresponsivepadding(context, 0.005, .005, .04, .04)
          , Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorpallete.darkblue,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.date_range,
                      color: colorpallete.darkblue,
                      size: 45,
                    ).Setresponsivepadding(context, .01, .01, .0, .02),
                    SizedBox(width: .01.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.tr.eventDate,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                              Text(
                                event.eventDate.length >= 11
                                    ? event.eventDate.substring(0, 11)
                                    : event.eventDate,
                                style: const TextStyle(
                                  color: colorpallete.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.tr.eventTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  )),
                              Text(
                                event.eventTime,
                                style: const TextStyle(
                                  color: colorpallete.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).Sethorizontalpadding(context, .03 ),
                    ),
                  ],
                ),
              ).Setresponsivepadding(context, .01, .01, .03, .03)

              ,event_locationcard(longitude: event.longitude,
                latitude: event.latitude,),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorpallete.darkblue,
                    width:1
                  )

                ),
               width: .95.w,
                height: .4.h,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(initialCameraPosition:
                  CameraPosition(zoom: 17,target: LatLng(event.latitude, event.longitude)),
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  markers: {
                    Marker(markerId: const MarkerId("0"),
                        position: LatLng(event.latitude, event.longitude))
                  },),
                ),
              ),
              Text(context.tr.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorpallete.darkblue,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )).Setresponsivepadding(context, .01, .01, 0, 0),
              Container(
                   width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: colorpallete.darkblue,
                          width:1
                      )

                  ),
                child: Text(event.desc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorpallete.darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    )).Setresponsivepadding(context, .01, .01, .02, .02),
              ).Setresponsivepadding(context, .01, .04, 0.02
                  , .02)


            ],
          ),
        ));
  }
}
