import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:events/moduls/createevent/creatingProvider.dart';

import '../../core/ColorPallete/colorpallete.dart'; // تأكد من المسار
class pick_location extends StatefulWidget {
  const pick_location({super.key});
  static const String picklocation = "/pick_location";

  @override
  State<pick_location> createState() => _pick_locationState();
}

class _pick_locationState extends State<pick_location> {
  Location location = Location();

  @override
  Widget build(BuildContext context) {
    final provider = ModalRoute.of(context)!.settings.arguments as CreatingProvider;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.getlocation();
          navigatorKey.currentState!.pop();
        },
        backgroundColor: colorpallete.darkblue,
        foregroundColor: colorpallete.parimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.my_location, size: 30),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (LatLng location) {
                provider.changeeventlocation(location); // ✅ نفس instance
                navigatorKey.currentState!.pop();
              },
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                provider.mapController = controller;
              },
              markers: provider.markers,
            ),
          ),
          Container(
            color: colorpallete.darkblue,
            height: .07.h,
            alignment: Alignment.center,
            child: Text(
              context.tr.taponlovationtoselect,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }
}
