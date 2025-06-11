import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/services/snackbarservice.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class CreatingProvider extends ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  EventModel? eventModel;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  int selectedTap = 0;
    String? Time_as_string;

  // Getters
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  // Tap
  void onTap(int index) {
    selectedTap = index;
    notifyListeners();
  }

   LatLng? eventlocation;

  void changeeventlocation(LatLng neweventlocation){
    eventlocation = neweventlocation ;
notifyListeners();
  }

  Future<bool> addEvent(BuildContext context) async {
    EasyLoading.show(status: context.tr.loading);

    try {
      // تحقق من الموقع
      if (eventlocation == null) {
        EasyLoading.dismiss();
        snackbar.showCustomNotification(
          message: context.tr.pleasechooselocation,
        );
        return false;
      }

      // التحقق من التاريخ والوقت
      if (selectedDate == null || selectedTime == null) {
        EasyLoading.dismiss();
        snackbar.showCustomNotification(
          message: context.tr.chooseDate, // ترجمها في ملف اللغات
        );
        return false;
      }

      // التحقق من العنوان والوصف
      if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) {
        EasyLoading.dismiss();
        snackbar.showCustomNotification(
          message: " please fill all fields", // ترجمها في ملف اللغات
        );
        return false;
      }


      // إنشاء الحدث
      final event = EventModel(
        title: titleController.text.trim(),
        desc: descriptionController.text.trim(),
        eventDate: selectedDate!.toIso8601String(),
        eventTime: selectedTime!.format(context),
        categoryId: Eventcategory.creationcategories[selectedTap].categorynam ?? "",
        categoryImage: Eventcategory.creationcategories[selectedTap].categoryimg ?? "",
        longitude: eventlocation!.longitude,
        latitude: eventlocation!.latitude,
      );

      await FirebaseFunctions.addEvent(event);

      // إخفاء اللودينج
      await EasyLoading.dismiss();

      // إشعار بالنجاح
      snackbar.showCustomNotification(
        message: context.tr.eventWasCreatedSuccessfully,
      );

      // تأخير بسيط قبل الإغلاق لضمان عرض الإشعار
      Future.delayed(const Duration(milliseconds: 100), () {
        navigatorkey.currentState?.pop();
      });

      return true;

    } catch (e) {
      await EasyLoading.dismiss();
      print("❌ Error in addEvent: $e");

      snackbar.showCustomErrormessage(
        message: context.tr.failedToCreateEvent,
      );

      return false;
    }
  }

  // Date Picker

  void setEventDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null && eventModel == null) {
      selectedDate = newDate;
      notifyListeners();
    }
    if (newDate != null && eventModel != null) {
      selectedDate = newDate;

      eventModel?.eventDate = newDate.toIso8601String();
      print(eventModel?.eventDate);
      notifyListeners();
    }
  }

  // Time Picker
  void setEventTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (newTime != null && eventModel == null) {
      selectedTime = newTime; // بدون var
      notifyListeners();
    }
    if (newTime != null && eventModel != null) {
      selectedTime = newTime;
      eventModel?.eventTime = newTime.format(context);
      print(eventModel?.eventTime);
      notifyListeners();
    }
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
      return;
    }
    bool locationservice = await  _locationserviseenabled();
    if (!locationservice) {
      return;
    } else {

      var locationdata = await location.getLocation();

      changelocationonmap(locationdata);

    }
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


  void initializedata(EventModel event) {
    eventModel = event;
    _titleController.text = event.title;
    _descriptionController.text = event.desc;
    selectedDate = DateTime.parse(event.eventDate);
    selectedTap = Eventcategory.creationcategories
        .indexWhere((element) => element.categorynam == event.categoryId);

     Time_as_string = event.eventTime;
    DateTime dt = DateFormat.jm().parse(event.eventTime); // ← يحلل "7:30 PM"
    selectedTime = TimeOfDay.fromDateTime(dt);
    eventlocation = LatLng(event.latitude, event.longitude);
  }

  Future<bool> editEvent(BuildContext context) async {

    EasyLoading.show(status: context.tr.loading); // نص زي "جاري التحميل..."

    try {
      if (eventlocation == null ) {
        snackbar.showCustomNotification(
          message: context.tr.pleasechooselocation,

        );
        return false ;
      }
      if (eventModel != null) {
        eventModel?.title = titleController.text;
        eventModel?.desc = descriptionController.text;
        eventModel?.eventDate = selectedDate?.toIso8601String() ?? "";
        eventModel?.eventTime = selectedTime?.format(context) ?? "";
        eventModel?.categoryId =
            Eventcategory.creationcategories[selectedTap].categorynam ?? "";
        eventModel?.categoryImage =
            Eventcategory.creationcategories[selectedTap].categoryimg ?? "";
        eventModel?.longitude = eventlocation?.longitude??0;
        eventModel?.latitude = eventlocation?.latitude??0;
      }
      await FirebaseFunctions.updateEvent(eventModel!);
      EasyLoading.dismiss();
      snackbar.showCustomNotification(
        message: context.tr.eventWasCreatedSuccessfully,

      );
      navigatorkey.currentState?.pop();
      return true;

    } catch (e) {
      EasyLoading.dismiss();
      snackbar.showCustomErrormessage(
        message: context.tr.failedToCreateEvent,
      );
      return false;
    }
  }










}

