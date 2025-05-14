import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

class event_locationcard extends StatefulWidget {

   const event_locationcard({super.key, required this.longitude, required this.latitude});

 final double longitude ;
   final double latitude ;

   @override
  State<event_locationcard> createState() => _event_locationcardState();
}
class _event_locationcardState extends State<event_locationcard> {
  String location = '';
   bool isLoading = true;

  @override
  void initState() {
    super.initState();
    geteventLocation();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: geteventLocation(), // ← هنا بنشغل الفانكشن
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            "Loading...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorpallete.darkblue,
            ),
          ).Setresponsivepadding(context, .01, .01, .02, .02);
        } else if (snapshot.hasError) {
          return const Text(
            "Location not available",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ).Setresponsivepadding(context, .01, .01, .02, .02);
        } else {
          String location = snapshot.data ?? "No location";

          return Container(
            height: .07.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: colorpallete.darkblue,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: colorpallete.darkblue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorpallete.darkblue,
                    ),
                  ).Setresponsivepadding(context, .01, .01, .02, .02),
                ),
              ],
            ),
          ).Setresponsivepadding(context, .00, .00, .025, .025);
        }
      },
    );
  }

  Future<String> geteventLocation() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // لو بتجرب
      var response = await GeoCode().reverseGeocoding(
          latitude: widget.latitude, longitude: widget.longitude);
      return "${response.countryName ?? ''} - ${response.streetAddress ?? ''}";
    } catch (e) {
      return "Unknown Location";
    }
  }
}
