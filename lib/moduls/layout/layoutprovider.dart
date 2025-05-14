
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/moduls/layout/favourite/fav_tap.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/location/map_tap.dart';
import 'package:events/moduls/layout/profile/profile_tap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

  class LayoutProvider extends ChangeNotifier {
    int selectedIndex = 0;
    int tapSelectedIndex = 0;
    String categoryId = '';

    List<EventModel> favEvents = [];
    bool isLoadingFav = false;

    /// ✅ Navigate
    void changeBottomNav(int index) {
      selectedIndex = index;
      notifyListeners();
    }

    void onTapSelected(int index) {
      tapSelectedIndex = index;
      notifyListeners();
    }

    List<Widget>  bottombarwidget = [
      HomeTap(),
      const map_tap(),
    const  SizedBox(),
       const fav_tap(),
     const ProfileTab(),
    ];

    List<Eventcategory> categories = [

      Eventcategory(
          categoryicon: Icons.all_inclusive_outlined,
          categoryimg: Appassets.Book_Club,
          categorynam: "All", id: '0'),

      Eventcategory(
          categoryicon: Icons.menu_book_outlined,
          categoryimg: Appassets.Book_Club,
          categorynam: "Book club", id: '1'),

      Eventcategory(
          categoryicon: Icons.bike_scooter,
          categoryimg: Appassets.sport,
          categorynam: "sports"
          , id: '2'),
      Eventcategory(
          categoryicon: Icons.cake_outlined,
          categoryimg: Appassets.Birthday,
          categorynam: "Birthday",
          id: '3'),
      Eventcategory(
          categoryicon: Icons.groups,
          categoryimg: Appassets.meeting,
          categorynam: "meeting",
          id: '4'),
      Eventcategory(
          categoryicon: Icons.holiday_village_outlined,
          categoryimg: Appassets.holiday,
          categorynam: "holiday",
          id: '5'),
      Eventcategory(
          categoryicon: Icons.fastfood_outlined,
          categoryimg: Appassets.eating,
          categorynam: "eating",
          id: '6'),
      Eventcategory(
          categoryicon: Icons.games_outlined,
          categoryimg: Appassets.gaming,
          categorynam: "gaming",
          id: '7'),
      Eventcategory(
          categoryicon: Icons.work_outline,
          categoryimg: Appassets.workshop,
          categorynam: "workshop",
          id: '8'),
      Eventcategory(
          categoryicon: Icons.park_outlined,
          categoryimg: Appassets.exhibtion,
          categorynam: "exhibtion",
          id: '9'),
    ];

    bool isLoading = false;

    List<EventModel> allEvents = [];
    List<EventModel> filteredEvents = [];

    Future<void> fetchAllEvents() async {
      try {
        // جلب البيانات من Firebase باستخدام الدالة getstreamdata
        var stream = FirebaseFunctions.getstreamdata();
        stream.listen((QuerySnapshot<EventModel> snapshot) {
          allEvents = snapshot.docs.map((doc) => doc.data()).toList();
          // نعرض جميع الأحداث في البداية
          filteredEvents = List.from(allEvents);
          notifyListeners(); // نحدث الواجهة
        });
      } catch (e) {
        print("Error fetching events: $e");
      }
    }


    Future<void> loadEventsByCategory(String categoryId) async {
      if (categoryId == '0' || categoryId == 'All' || categoryId == 'all') {
        fetchAllEvents();
      } else {
        try {
          // جلب البيانات من Firebase باستخدام الدالة getstreamdata
          var stream = FirebaseFunctions.getEventsByCategory(categoryId);
          stream.listen((QuerySnapshot<EventModel> snapshot) {
            allEvents = snapshot.docs.map((doc) => doc.data()).toList();
            // نعرض جميع الأحداث في البداية
            filteredEvents = List.from(allEvents);
            notifyListeners(); // نحدث الواجهة
          });
        } catch (e) {
          print("Error fetching events: $e");
        }
      }
    }



    Future<void> getfavevent(BuildContext context) async {
      favEvents.clear(); // مهم علشان ما تتكررش الأحداث

      try {
        // جلب البيانات من Firebase باستخدام الدالة getstreamdata
        var stream = FirebaseFunctions.getFavEventsStream();
        stream.listen((QuerySnapshot<EventModel> snapshot) {
          favEvents = snapshot.docs.map((doc) => doc.data()).toList();
          // نعرض جميع الأحداث في البداية
          notifyListeners(); // نحدث الواجهة
        });
      } catch (e) {
        print("Error fetching events: $e");
      }

      notifyListeners();  // Notify listeners to update the UI after data is fetched
    }



    Location location = Location();

    String locationmessage = "";

    late GoogleMapController mapController;

      CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(30.0444, 31.2357),
      zoom: 14.4746,
    );

    Set<Marker> markers = {
      const Marker(
        markerId: MarkerId('marker1'),
        position:LatLng(
          37.42796133580664,
          -122.085749655962,
        ),
      ),

    };

    Future<void> getlocation() async {
      bool isLocationEnabled = await _getlocationperrmisions();
      if(isLocationEnabled==false){
        notifyListeners();
        return;
      }
      bool locationservice = await  _locationserviseenabled();
        if (!locationservice) {
          notifyListeners();
          return;
        } else {

          var locationdata = await location.getLocation();

            changelocationonmap(locationdata);

        }
      }


    void setlocationlistener(){

       location.changeSettings(

          accuracy: LocationAccuracy.high,
          interval: 1000,
          distanceFilter: 10,
        );
      location.onLocationChanged.listen((LocationData){
        changelocationonmap(LocationData);

      });

    }

   void changelocationonmap( LocationData locationdata){


     cameraPosition = CameraPosition(
         target: LatLng(locationdata.latitude?? 0, locationdata.longitude??0),
         zoom: 17);
     markers = {
       Marker(
         markerId:  const MarkerId('marker1'),
         position: LatLng(locationdata.latitude?? 0, locationdata.longitude??0),
       )};

     mapController.animateCamera(CameraUpdate.newCameraPosition(
         CameraPosition(
           target: LatLng(locationdata.latitude?? 0, locationdata.longitude??0),
           zoom: 17
         )
     ));
      notifyListeners();
   }


   void gotoeventlocation( LatLng eventlocation  ){

      cameraPosition = CameraPosition(
          target: eventlocation,
          zoom: 17);
      markers = {
        Marker(
          markerId:  const MarkerId('marker1'),
          position: eventlocation,
        )};

      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: eventlocation,
              zoom: 17
          )
      ));
      notifyListeners();

   }


    Future<bool> _getlocationperrmisions() async{

      var permissionstatus =await location.hasPermission();
      if(permissionstatus == PermissionStatus.denied){
        permissionstatus = await location.requestPermission();
      }
    return permissionstatus == PermissionStatus.granted;

    }


    Future<bool> _locationserviseenabled()async{

      var serviseenabled = await location.serviceEnabled();
      if(serviseenabled == false){
        serviseenabled = await location.requestService();
      }
      return serviseenabled;

    }

    TextEditingController edittitle = TextEditingController();
    TextEditingController editDesc = TextEditingController();





  }


