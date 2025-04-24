
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/services/snackbarservice.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/main.dart';
import 'package:events/moduls/layout/favourite/fav_tap.dart';
import 'package:events/moduls/layout/home/home_tap.dart';
import 'package:events/moduls/layout/location/map_tap.dart';
import 'package:events/moduls/layout/profile/profile_tap.dart';
import 'package:flutter/material.dart';

  import 'package:events/core/models/Eventdata.dart';
  import 'package:flutter/material.dart';

  class LayoutProvider extends ChangeNotifier {
    int selectedIndex = 0;
    int tapSelectedIndex = 0;
    String categoryId = '';

    List<EventModel> favEvents = [];

    /// ✅ Navigate
    void changeBottomNav(int index) {
      selectedIndex = index;
      notifyListeners();
    }

    void onTapSelected(int index) {
      tapSelectedIndex = index;
      notifyListeners();
    }

    List<Widget> bottombarwidget = [
      HomeTap(),
      map_tap(),
      SizedBox(),
      fav_tap(),
      ProfileTab(),
    ];
    bool hasFetched = false;


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
      if(categoryId == '0' || categoryId == 'All' || categoryId == 'all') {
        // إذا كانت الفئة هي "All"، نعرض جميع الأحداث
        filteredEvents = List.from(allEvents);
      } else
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



      Future<void> getfavevent(BuildContext context) async {

        favEvents.clear(); // مهم علشان ما تتكررش الأحداث

        try {
          var favouriteEvents = await FirebaseFunctions.getFavEvents();


          for (var element in favouriteEvents) {
            favEvents.add(element.data());
          }

          notifyListeners();
        } catch (e) {
          snackbar.showCustomErrormessage(
            message: context.tr.somethingWentWrong,
          );
        }
      }


    Future<void> setfavourit(EventModel event) async {
      // تحديث حالة الإعجاب في Firebase
      await FirebaseFunctions.setFav(event);

      // إعادة تحميل البيانات لتحديث واجهة المستخدم بعد التغيير
      await fetchAllEvents();  // تأكد من أنك تقوم بإعادة تحميل البيانات بعد التحديث
      notifyListeners();
    }




  }