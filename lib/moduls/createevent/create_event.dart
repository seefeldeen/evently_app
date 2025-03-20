import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/services/snackbarservice.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/EventTypeTab.dart';
import 'package:events/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  static const String routename = "/createevent";
  CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent>
    with TickerProviderStateMixin {
  TextEditingController _titlecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TextEditingController _discreptioncontroller = TextEditingController();

  TimeOfDay? selectedtime;

  DateTime? selecteddate;

  int selectedtap = 0;

  List<Eventcategory> categories = [
    Eventcategory(
        categoryicon: Icons.menu_book_outlined,
        categoryimg: Appassets.Book_Club,
        categorynam: "Book club"),
    Eventcategory(
        categoryicon: Icons.bike_scooter,
        categoryimg: Appassets.sport,
        categorynam: "sports"),
    Eventcategory(
        categoryicon: Icons.cake_outlined,
        categoryimg: Appassets.Birthday,
        categorynam: "Birthday"),
    Eventcategory(
        categoryicon: Icons.groups,
        categoryimg: Appassets.meeting,
        categorynam: "meeting"),
    Eventcategory(
        categoryicon: Icons.holiday_village_outlined,
        categoryimg: Appassets.holiday,
        categorynam: "holiday"),
    Eventcategory(
        categoryicon: Icons.fastfood_outlined,
        categoryimg: Appassets.eating,
        categorynam: "eating"),
    Eventcategory(
        categoryicon: Icons.games_outlined,
        categoryimg: Appassets.gaming,
        categorynam: "gaming"),
    Eventcategory(
        categoryicon: Icons.work_outline,
        categoryimg: Appassets.workshop,
        categorynam: "workshop"),
    Eventcategory(
        categoryicon: Icons.park_outlined,
        categoryimg: Appassets.exhibtion,
        categorynam: "exhibtion"),
  ];

  late TabController _tabController;

  List<String> TAPBARIMAGE = [
    Appassets.Book_Club,
    Appassets.sport,
    Appassets.Birthday,
    Appassets.meeting,
    Appassets.holiday,
    Appassets.eating,
    Appassets.gaming,
    Appassets.workshop,
    Appassets.exhibtion,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TAPBARIMAGE.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedtap =
            _tabController.index; // Update selectedtap when the tab changes
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Customtextshape.Getbigtextchoose(
              "Create event", context, colorpallete.darkblue),
          shadowColor: Colors.black.withOpacity(0.3)),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    TAPBARIMAGE[_tabController.index], // Corrected here
                    height: .22.h,
                    width: .95.w,
                    fit: BoxFit.cover,
                  ).Setoptionalpadding(context, .001.h, .01.h, 0.01.w, .01.w),
                ),
                DefaultTabController(
                  length:
                      TAPBARIMAGE.length, // Length based on the number of tabs
                  child: SizedBox(
                    height: .06.h,
                    width: 1.w,
                    child: TabBar(
                      controller: _tabController, // Link TabController
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      tabs: categories.map((category) {
                        return Eventtypetab(
                          text: category
                              .categorynam, // Use category name dynamically
                          iconns: category
                              .categoryicon, // Use category icon dynamically
                          isselected:
                              categories.indexOf(category) == selectedtap,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Text("Title", style: TextStyle(fontWeight: FontWeight.w500))
                    .Setoptionalpadding(context, .01.h, .01.h, .87.w, .05.w),
                CustomTextField(
                        controller: _titlecontroller,
                        prefixIcon: Icons.edit_note_sharp,
                        hintText: "what is next.. !? ")
                    .Setoptionalpadding(
                        context, .009.h, .009.h, .015.w, .015.w),
                Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ).Setoptionalpadding(context, .01.h, .01.h, .75.w, .04.w),
                CustomTextField(
                        controller: _discreptioncontroller,
                        maximumlines: 5,
                        hintText: "want something to reminder you !?")
                    .Setoptionalpadding(
                        context, .009.h, .009.h, .015.w, .015.w),
                Row(
                  children: [
                    Icon(Icons.date_range_rounded),
                    SizedBox(width: 8),
                    Text("Event date"),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          seteventdate(context);
                        },
                        child: Text(
                          selecteddate != null
                              ? DateFormat("dd MMM yyyy").format(selecteddate!)
                              : "choose date",
                          style: TextStyle(
                              color: colorpallete.darkblue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ))
                  ],
                ).Setoptionalpadding(context, .009.h, .009.h, .03.w, .03.w),
                ElevatedButton(
                  onPressed: () {
                    navigatorkey.currentState!
                        .pushReplacementNamed(route_names.layout);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colorpallete.darkblue),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.my_location,
                        color: colorpallete.darkblue,
                        size: 26,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "choose event location",
                        style: TextStyle(
                            color: colorpallete.darkblue, fontSize: 18),
                      ),
                      Spacer(),
                      Icon(
                        Icons.navigate_next_rounded,
                        color: colorpallete.darkblue,
                        size: 26,
                      ),
                    ],
                  ),
                ).Setoptionalpadding(context, 12, 2, 12, 12),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (selecteddate != null) {
                        var thenewevent = Eventdata(
                            eventtitle: _titlecontroller.text,
                            isfav: false,
                            description: _discreptioncontroller.text,
                            eventdate: selecteddate ?? DateTime.now(),
                            eventimage: categories[selectedtap].categoryimg,
                            eventcategory: categories[selectedtap].categorynam);

                        EasyLoading.show();
                        FirebaseFunctions.createvent(thenewevent).then((value) {
                          EasyLoading.dismiss();
                          if (value == true) {
                            // Only pop if the event is successfully created
                            navigatorkey.currentState!.pop();
                            snackbar.showCustomNotification(
                                message: "Event was created successfully");
                          } else {
                            // Handle event creation failure here (optional)
                            snackbar.showCustomErrormessage(
                                message: "Failed to create event.");
                          }
                        });
                      } else {
                        // If no date is selected, show an error message and stay on the same screen
                        snackbar.showCustomErrormessage(
                            message: "Please choose a date.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorpallete.darkblue,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "Save Event",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),
                ).Setoptionalpadding(context, 12, 2, 12, 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void seteventdate(context) async {
    DateTime? newdate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (newdate != null) {
      setState(() {
        selecteddate = newdate;
      });
    }
  }
}
