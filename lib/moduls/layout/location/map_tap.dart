import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/moduls/layout/layoutprovider.dart';
import 'package:events/moduls/layout/location/mapeventcard.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
class map_tap extends StatefulWidget {
  const map_tap({super.key});

  @override
  State<map_tap> createState() => _map_tapState();
}

class _map_tapState extends State<map_tap> {

  Location location = Location();

 late LayoutProvider mainprovider;


  @override
  Widget build(BuildContext context) {
   mainprovider =   Provider.of(context);
    return  Consumer<LayoutProvider>(

        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(


 floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton:  FloatingActionButton(
              onPressed: () {
                provider.getlocation();
                } ,
            backgroundColor: colorpallete.darkblue,
            foregroundColor: colorpallete.parimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.my_location,size: 30,) ,) ,
              body:
            Stack(
              children: [
                GoogleMap(
                initialCameraPosition: provider.cameraPosition,
                onMapCreated: (controller) {
                  provider.mapController = controller;
                  // <-- هنا يكون مضمون إن الـ controller جاهز
                },
                markers: provider.markers,
              ),
                Positioned(
                  height: .15.h,
                    width: .9.w,
                  bottom: .022.h,

                    child: StreamBuilder(stream: FirebaseFunctions.getstreamdata(),
              builder: (context, snapshot) {
                var data = snapshot.data?.docs ?? [];
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      var events = data[index].data();
                      return Mapeventcard(
                        eventModel: events,
                        onpress: (lat, long) {
                          provider.gotoeventlocation(LatLng(lat, long));
                        },
                      );
                    }
                );
              }
              )
                    )
    ]
            )
          );

        }
    );
 }
}
