import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/services/snackbarservice.dart';
import 'package:events/core/utill/Firebasefunctions/firebasefunctions.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/EventTypeTab.dart';
import 'package:events/main.dart';
import 'package:events/moduls/createevent/creatingProvider.dart';
import 'package:events/moduls/layout/Widgets/hometapbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CreateEvent extends StatelessWidget {
  static const String routename = "/createevent";


  CreateEvent({super.key});


  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<app_provider>(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
        create: (context) => CreatingProvider(),

      child:  Scaffold(
        appBar: AppBar(
            actionsIconTheme: appprovider.currenttheme == ThemeMode.dark
                ? IconThemeData(color: Colors.white)
                : IconThemeData(color: Colors.black),
            centerTitle: true,
            title: Customtextshape.Getbigtextchoose(
                context.tr.createEvent, context, colorpallete.parimary),
            shadowColor: Colors.black.withOpacity(0.3)
        ),
        
        body:
    Consumer<CreatingProvider>(
    builder: (BuildContext context, createprovider, child) {
      return SingleChildScrollView(
        child: Center(
          child:
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: .01.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              Eventcategory.creationcategories[createprovider.selectedTap].categoryimg, // Corrected here
                              height: .26.h,
                              width: .90.w,
                              fit: BoxFit.cover,
                            ).Setoptionalpadding(context, .001.h, .01.h, 0.01.w, .01.w),
                          ),
                DefaultTabController(
                  initialIndex: createprovider.selectedTap,
                  length: Eventcategory.creationcategories.length, // Length based on the number of tabs
                  child: SizedBox(
                    height: .06.h,
                    width: 1.w,
                    child: TabBar(
                      onTap: (index) => createprovider.onTap(index),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      tabs: Eventcategory.creationcategories.map((category) {
                        return Eventtypetab(
                          text: category
                              .categorynam, // Use category name dynamically
                          iconns: category
                              .categoryicon, // Use category icon dynamically
                          isselected:
                          Eventcategory.creationcategories.indexOf(category) ==
                              createprovider.selectedTap,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                          Customtextshape.Getbigtextchoose(
                              context.tr.title, context,
                              colorpallete.darkblue)
                              .Setresponsivepadding(context, .01, .01, .02, .02),
                          CustomTextField(
                              controller: createprovider.titleController,
                              prefixIcon: Icon(Icons.notes),
                              hintText: "what is next.. !? ")
                              .Setoptionalpadding(
                              context, .009.h, .009.h, .015.w, .015.w),
                          Customtextshape.Getbigtextchoose(
                              context.tr.description, context,
                              colorpallete.darkblue)
                              .Setresponsivepadding(context, .01, .01, .02, .02)
                          ,CustomTextField(
                              controller: createprovider.descriptionController,
                              maxLine: 5,
                              hintText: context.tr.wantSomethingToReminderYou)
                              .Setoptionalpadding(
                              context, .009.h, .009.h, .015.w, .015.w),
                          Row(
                            children: [
                              Icon(Icons.date_range_rounded,color: colorpallete.darkblue,),
                              SizedBox(width: 8),
                              Text(context.tr.eventDate),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    createprovider.setEventDate(context);
                                  },
                                  child: Text(
                                    createprovider.selectedDate != null
                                        ? DateFormat("dd MMM yyyy").format(createprovider.selectedDate!)
                                        : context.tr.chooseDate,
                                    style: TextStyle(
                                        color: colorpallete.darkblue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )),

                            ],
                          ).Setoptionalpadding(context, .009.h, .009.h, .03.w, .03.w),
                          Row(
                            children: [
                              Icon(Icons.access_time,color: colorpallete.darkblue,),
                              Text("  "+context.tr.eventTime),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  createprovider.setEventTime(context);
                                },
                                child: Text(
                                  createprovider.selectedTime == null
                                      ? context.tr.choosetime:
                                  MaterialLocalizations.of(context).formatTimeOfDay(
                                    createprovider.selectedTime!,
                                    alwaysUse24HourFormat: true,
                                  ),
                                  style: TextStyle(
                                    color: colorpallete.darkblue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ).Setoptionalpadding(context, .009.h, .009.h, .03.w, .03.w)

                          ,ElevatedButton(
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
                                  context.tr.chooseEventLocation,
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
                                if (createprovider.selectedDate != null) {

                               createprovider.addEvent(context);

                                } else {
                                  // If no date is selected, show an error message and stay on the same screen
                                  snackbar.showCustomErrormessage(
                                      message: context.tr.pleaseChooseADate);
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
                              context.tr.saveEvent,
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
      );
    }
    )
        )
      );
    }
  }



  // List<Eventcategory> categories = [
  //   Eventcategory(
  //       categoryicon: Icons.menu_book_outlined,
  //       categoryimg: Appassets.Book_Club,
  //       categorynam: "Book club"),
  //   Eventcategory(
  //       categoryicon: Icons.bike_scooter,
  //       categoryimg: Appassets.sport,
  //       categorynam: "sports"),
  //   Eventcategory(
  //       categoryicon: Icons.cake_outlined,
  //       categoryimg: Appassets.Birthday,
  //       categorynam: "Birthday"),
  //   Eventcategory(
  //       categoryicon: Icons.groups,
  //       categoryimg: Appassets.meeting,
  //       categorynam: "meeting"),
  //   Eventcategory(
  //       categoryicon: Icons.holiday_village_outlined,
  //       categoryimg: Appassets.holiday,
  //       categorynam: "holiday"),
  //   Eventcategory(
  //       categoryicon: Icons.fastfood_outlined,
  //       categoryimg: Appassets.eating,
  //       categorynam: "eating"),
  //   Eventcategory(
  //       categoryicon: Icons.games_outlined,
  //       categoryimg: Appassets.gaming,
  //       categorynam: "gaming"),
  //   Eventcategory(
  //       categoryicon: Icons.work_outline,
  //       categoryimg: Appassets.workshop,
  //       categorynam: "workshop"),
  //   Eventcategory(
  //       categoryicon: Icons.park_outlined,
  //       categoryimg: Appassets.exhibtion,
  //       categorynam: "exhibtion"),
  // ];
  //
  // late TabController _tabController;
  //
  // List<String> TAPBARIMAGE = [
  //   Appassets.Book_Club,
  //   Appassets.sport,
  //   Appassets.Birthday,
  //   Appassets.meeting,
  //   Appassets.holiday,
  //   Appassets.eating,
  //   Appassets.gaming,
  //   Appassets.workshop,
  //   Appassets.exhibtion,
  // ];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: TAPBARIMAGE.length, vsync: this);
  //   _tabController.addListener(() {
  //     setState(() {
  //       selectedtap =
  //           _tabController.index; // Update selectedtap when the tab changes
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(

  //     body: SingleChildScrollView(
  //       child: Center(
  //         child: Form(
  //           key: formKey,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               SizedBox(height: .01.h),
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(30),
  //                 child: Image.asset(
  //                   TAPBARIMAGE[_tabController.index], // Corrected here
  //                   height: .26.h,
  //                   width: .90.w,
  //                   fit: BoxFit.cover,
  //                 ).Setoptionalpadding(context, .001.h, .01.h, 0.01.w, .01.w),
  //               ),
  //


  //
  //