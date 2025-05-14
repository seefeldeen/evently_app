import 'package:events/core/ColorPallete/colorpallete.dart';
import 'package:events/core/extensions/PaddingExtention.dart';
import 'package:events/core/extensions/SizeExtention.dart';
import 'package:events/core/manager/app_provider.dart';
import 'package:events/core/models/Eventcategory.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:events/core/routes/route_names.dart';
import 'package:events/core/widgets/Customformfield.dart';
import 'package:events/core/widgets/Customtextshape.dart';
import 'package:events/core/widgets/EventTypeTab.dart';
import 'package:events/main.dart';
import 'package:events/moduls/createevent/creatingProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  static const String routename = "/createevent";

  final EventModel? event;
  const CreateEvent({super.key, this.event});


  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {


  CreatingProvider eventprovider = CreatingProvider();
  @override
  void initState() {
    if( widget.event != null){
eventprovider.initializedata(widget.event!); }

  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final appprovider = Provider.of<app_provider>(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider.value(
        value : eventprovider,
        child: Scaffold(
            appBar: AppBar(
                actionsIconTheme: appprovider.currenttheme == ThemeMode.dark
                    ? const IconThemeData(color: Colors.white)
                    : const IconThemeData(color: Colors.black),
                centerTitle: true,
                title: Customtextshape.Getbigtextchoose(
                    context.tr.createEvent, context, colorpallete.parimary),
                shadowColor: Colors.black.withOpacity(0.3)),
            body: Consumer<CreatingProvider>(
                builder: (BuildContext context, createprovider, child) {
              return SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: .01.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            Eventcategory
                                .creationcategories[createprovider.selectedTap]
                                .categoryimg, // Corrected here
                            height: .25.h,
                            fit: BoxFit.cover,
                          ).Setoptionalpadding(
                              context, .001.h, .01.h, 0.015.w, .015.w),
                        ),
                        DefaultTabController(
                          initialIndex: createprovider.selectedTap,
                          length: Eventcategory.creationcategories
                              .length, // Length based on the number of tabs
                          child: SizedBox(
                            height: .06.h,
                            width: 1.w,
                            child: TabBar(
                              onTap: (index) => createprovider.onTap(index),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                              tabAlignment: TabAlignment.start,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              indicatorColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                              isScrollable: true,
                              tabs: Eventcategory.creationcategories
                                  .map((category) {
                                return Eventtypetab(
                                  text: category
                                      .categorynam, // Use category name dynamically
                                  iconns: category
                                      .categoryicon, // Use category icon dynamically
                                  isselected: Eventcategory.creationcategories
                                          .indexOf(category) ==
                                      createprovider.selectedTap,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Customtextshape.Getbigtextchoose(context.tr.title,
                                context, colorpallete.darkblue)
                            .Setresponsivepadding(context, .01, .01, .02, .02),
                        CustomTextField(
                                controller: createprovider.titleController,
                                prefixIcon: const Icon(Icons.notes),
                                hintText: "what is next.. !? ")
                            .Setoptionalpadding(
                                context, .009.h, .009.h, .015.w, .015.w),
                        Customtextshape.Getbigtextchoose(context.tr.description,
                                context, colorpallete.darkblue)
                            .Setresponsivepadding(context, .01, .01, .02, .02),
                        CustomTextField(
                                controller:
                                    createprovider.descriptionController,
                                maxLine: 5,
                                hintText: context.tr.wantSomethingToReminderYou)
                            .Setoptionalpadding(
                                context, .009.h, .009.h, .015.w, .015.w),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_rounded,
                              color: colorpallete.darkblue,
                            ),
                            const SizedBox(width: 8),
                            Text(context.tr.eventDate),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  createprovider.setEventDate(context);
                                },
                                child: Text(
                                  createprovider.selectedDate != null
                                      ? DateFormat("dd MMM yyyy")
                                          .format(createprovider.selectedDate!)
                                      : context.tr.chooseDate,
                                  style: const TextStyle(
                                      color: colorpallete.darkblue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          ],
                        ).Setoptionalpadding(
                            context, .009.h, .009.h, .03.w, .03.w),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: colorpallete.darkblue,
                            ),
                            Text("  ${context.tr.eventTime}"),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                createprovider.setEventTime(context);
                              },
                              child: Text(
                              eventprovider.eventModel != null ?
                                eventprovider.eventModel!.eventTime:
                                createprovider.selectedTime == null
                                    ? context.tr.choosetime
                                    : MaterialLocalizations.of(context)
                                        .formatTimeOfDay(
                                        createprovider.selectedTime!,
                                        alwaysUse24HourFormat: true,
                                      ),
                                style: const TextStyle(
                                  color: colorpallete.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ).Setoptionalpadding(
                            context, .009.h, .009.h, .03.w, .03.w),
                        ElevatedButton(
                          onPressed: () {
                            navigatorkey.currentState!
                                .pushNamed(route_names.picklocation,
                                arguments: createprovider);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: colorpallete.darkblue),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.my_location,
                                color: colorpallete.darkblue,
                                size: 26,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                createprovider.eventlocation == null
                                    ? context.tr.chooseEventLocation
                                    : "location :${createprovider.eventlocation!.latitude.floor()} :"
                                        "${createprovider.eventlocation!.longitude.floor()} ",
                                style: const TextStyle(
                                    color: colorpallete.darkblue, fontSize: 18),
                              ),
                              const Spacer(),
                              const Icon(
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
                              if (createprovider.selectedDate != null
                                &&createprovider.eventModel == null) {
                                createprovider.addEvent(context);
                              } else
                              if (createprovider.selectedDate != null &&
                                  createprovider.eventModel != null) {
                                createprovider.editEvent(context);
                                navigatorkey.currentState!.popUntil(
                                    (route) => route.settings.name ==
                                        route_names.layout);


                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorpallete.darkblue,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            createprovider.eventModel != null
                                ? context.tr.editevent
                                : context.tr.createEvent,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Inter"),
                          ),
                        ).Setoptionalpadding(context, 12, 10, 12, 12),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}
