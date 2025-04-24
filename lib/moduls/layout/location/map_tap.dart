import 'package:flutter/material.dart';
import 'package:location/location.dart';
class map_tap extends StatelessWidget {
   map_tap({super.key});
Location location = Location();
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }




  // Future<void> getLocation()  async{
  //
  //   bool locatiopermissionGranted = await  _getlocationpermission();
  //
  //
  // }


//    Future <bool> _getlocationpermission() async{
//
//      var permissionstatus = await location.hasPermission();
//
//      if (permissionstatus == PermissionStatus.denied) {
//        permissionstatus = await location.requestPermission();
//        if (permissionstatus == PermissionStatus.granted) {
//          return ;
//        }
//      }
// }



}
