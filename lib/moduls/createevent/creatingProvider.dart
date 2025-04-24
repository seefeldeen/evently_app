import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/services/snackbarservice.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreatingProvider with ChangeNotifier {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  int selectedTap = 0;

  // Getters
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;

  // Tap
  void onTap(int index) {
    selectedTap = index;
    notifyListeners();
  }


  Future<bool> addEvent(BuildContext context) async {

    EasyLoading.show(status: context.tr.loading); // نص زي "جاري التحميل..."

    try {

      await FirebaseFunctions.addEvent(EventModel(
        title: titleController.text,
        desc: descriptionController.text,
        eventDate: selectedDate?.toIso8601String() ?? "",
        eventTime: selectedTime?.format(context) ?? "",
        categoryId: Eventcategory.creationcategories[selectedTap].categorynam ?? "",
        categoryImage: Eventcategory.creationcategories[selectedTap].categoryimg ?? "",
      ));
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

  // Date Picker

  void setEventDate(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (newDate != null) {
      selectedDate = newDate;
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

    if (newTime != null) {
      selectedTime = newTime; // بدون var
      notifyListeners();
    }
  }
}
